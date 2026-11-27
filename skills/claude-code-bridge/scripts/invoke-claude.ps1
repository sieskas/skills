[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("auto", "handoff")]
    [string]$Mode,

    [Parameter(Mandatory = $true)]
    [string]$Repo,

    [Parameter(Mandatory = $true)]
    [string]$TaskFile,

    [string]$Name = "[AGY] Tache deleguee",
    [string]$Resume = "",
    [string]$PermissionMode = "acceptEdits",
    [int]$MaxTurns = 25,
    [string]$Model = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Repo)) {
    throw "Le dossier projet est introuvable : $Repo"
}
if (-not (Test-Path -LiteralPath $TaskFile)) {
    throw "Le fichier de brief est introuvable : $TaskFile"
}

# Exclure .agent-bridge/ localement dans Git sans toucher au .gitignore du projet
$gitExclude = Join-Path $Repo ".git\info\exclude"
if (Test-Path -LiteralPath $gitExclude) {
    $excludeContent = Get-Content -LiteralPath $gitExclude -Raw -ErrorAction SilentlyContinue
    if ($excludeContent -notmatch "(?m)^\.agent-bridge/?$") {
        Add-Content -LiteralPath $gitExclude -Value "`n.agent-bridge/"
    }
}

# Resoudre le chemin relatif du fichier de brief par rapport au repo
$repoFull = (Resolve-Path -LiteralPath $Repo).Path.TrimEnd('\')
$taskFull = (Resolve-Path -LiteralPath $TaskFile).Path
if ($taskFull.StartsWith($repoFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    $relativeTask = $taskFull.Substring($repoFull.Length).TrimStart('\') -replace '\\', '/'
} else {
    $relativeTask = $taskFull
}

$shortPrompt = "Lis le brief dans ``$relativeTask`` et implemente exactement ce qui est demande. A la fin, fais un resume concis des fichiers modifies et des verifications effectuees."

function Find-ClaudeBinary {
    $cmd = Get-Command claude -ErrorAction SilentlyContinue
    if ($cmd) {
        return $cmd.Source
    }

    $claudeDataRoot = Join-Path $env:LOCALAPPDATA "Claude-Data"
    if (Test-Path -LiteralPath $claudeDataRoot) {
        $candidates = Get-ChildItem -Path $claudeDataRoot -Recurse -Filter "claude.exe" -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -match "claude-code" } |
            Sort-Object LastWriteTime -Descending
        if ($candidates) {
            return $candidates[0].FullName
        }
    }

    throw "Impossible de trouver claude.exe (ni dans PATH, ni dans $claudeDataRoot)."
}

if ($Mode -eq "handoff") {
    Set-Clipboard -Value $shortPrompt

    # Amener la fenetre Claude Desktop au premier plan si elle tourne
    $proc = Get-Process -Name "claude" -ErrorAction SilentlyContinue |
        Where-Object { $_.MainWindowHandle -ne 0 } |
        Select-Object -First 1

    if ($proc) {
        Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32Focus {
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
}
"@
        [Win32Focus]::ShowWindowAsync($proc.MainWindowHandle, 9) | Out-Null
        [Win32Focus]::SetForegroundWindow($proc.MainWindowHandle) | Out-Null
    }

    [PSCustomObject]@{
        mode       = "handoff"
        repo       = $repoFull
        task_file  = $relativeTask
        clipboard  = $shortPrompt
        focused    = [bool]$proc
    } | ConvertTo-Json -Depth 3
    exit 0
}

# Mode auto : appel direct au binaire claude.exe (meme moteur et sessions que Claude Desktop)
$claudeExe = Find-ClaudeBinary

$argsList = @(
    "-p", $shortPrompt,
    "--output-format", "json",
    "--permission-mode", $PermissionMode,
    "--max-turns", "$MaxTurns"
)

if ($Resume) {
    $argsList += @("--resume", $Resume)
} elseif ($Name) {
    $argsList += @("--name", $Name)
}

if ($Model) {
    $argsList += @("--model", $Model)
}

Push-Location -LiteralPath $repoFull
try {
    & $claudeExe @argsList
    $exitCode = $LASTEXITCODE
} finally {
    Pop-Location
}

exit $exitCode
