---
name: ideation-saas
description: >-
  Generates original, monetizable feature, acquisition, or pricing ideas for a SaaS product while
  bypassing LLM mode collapse. Combines proven AI creativity techniques (Verbalized Sampling,
  strict CreativeDC Divergence/Convergence separation, Ethan Mollick's anti-cliche blacklist,
  cross-industry collisions) with frameworks from top SaaS product leaders (Teresa Torres,
  Elena Verna, Kyle Poyar, Bob Moesta, Lenny Rachitsky, Shreyas Doshi). Use whenever the user
  wants new SaaS feature ideas, higher MRR, more customers, higher ARPU, or new product growth levers.
---

# Inventive & Monetizable SaaS Ideation

An anti-cliche method for discovering SaaS features that genuinely drive **more customers** or **more revenue**, explicitly breaking LLM statistical-average bias (*mode collapse*).

## Golden Rule: Never Brainstorm Cold or in a Single Pass

A generic prompt ("give me 10 feature ideas for my SaaS") always yields the same cliches (AI copilot, referral program, generic Enterprise tier). This skill enforces **4 non-negotiable guardrails**:
1. Anchor ideation in **real user friction** and a **specific business lever**.
2. **Explicitly ban** the obvious ideas before starting.
3. **Strictly separate** wild divergence from ruthless business filtering.
4. **Stress-test every finalist** with a skeptical review before recommending it.

---

## Step 1: Express Framing (Max 4 Questions)

If the user has not yet described their SaaS, ask at most **4 short questions** in a single message:
1. **Product & roles:** What does your SaaS do in 2 sentences? Who **uses** it daily, and who **pays** the bill?
2. **Current pricing:** How do you charge today (per seat, usage, flat subscription, freemium...) and what is your average ticket / ARPU?
3. **Priority lever:** Are you mainly aiming for **more customers** (acquisition / conversion) or **more revenue per customer** (expansion / upsell / retention)?
4. **Real raw material (optional, high leverage):** What are 2-3 painful things customers still do *manually* outside your tool, or the top reasons for churn / lost deals?

*If the user supplies real evidence (support tickets, call notes, reviews, codebase), first extract **manual workarounds** and **friction moments** citing exact facts — never invent fictional needs.*

---

## Step 2: Business Angle Mapping (Torres + Verna + Moesta + Poyar + Rachitsky)

Before ideating a single feature, run a quick **5-angle diagnostic** (1-2 lines per angle, focused on the priority lever):

| Leader | Angle to Inspect |
|---|---|
| **Teresa Torres** (*Opportunity Solution Tree*) | What **manual workarounds** (CSV exports, copy-pasting, manual emails) prove an unsolved pain? |
| **Elena Verna** (*Monetization-Led Growth*) | What **buyer/decision-maker feature** (control, governance, team visibility, ROI proof) is missing alongside end-user features? |
| **Bob Moesta** (*Jobs-to-be-Done*) | What **anxiety or habit** blocks prospects at the *Switch Moment*? |
| **Kyle Poyar** (*Pricing & Packaging*) | What feature would drive **3x higher consumption** of the value metric or justify an **add-on / hybrid model** (base + credits/usage)? |
| **Lenny Rachitsky** (*Growth Loops*) | What artifact or internal workflow could **expose the SaaS** to existing users' clients, teammates, or partners? |

---

## Step 3: Anti-Cliche Blacklist (Mode Collapse Antidote — Ethan Mollick)

Briefly list the **10 most obvious / generic ideas** that any PM or LLM would suggest first for this SaaS (e.g. *"add an AI chatbot"*, *"affiliate program"*, *"Zapier integration"*, *"dark mode"*, *"generic analytics dashboard"*).

**Formally declare these 10 ideas banned** for the rest of the session.

---

## Step 4: Pure DIVERGENCE (CreativeDC + Verbalized Sampling)

> **Strict constraint:** during this step, **zero filtering** by technical feasibility, dev cost, or "common sense." The goal is to escape the default probability cluster.

Generate **16 to 20 original ideas** across **4 creative engines**:

1. **Verbalized Sampling — Long Tail (`p < 0.10`)** *(5 ideas)*:
   - Keep only ideas with an estimated **< 10% probability** of being suggested by a conventional PM.
   - For each idea, explicitly state `[p ~ 0.0X]` and **which industry norm it breaks**.
2. **Cross-Industry Collisions** *(5 ideas)*:
   - Transplant high-revenue mechanics from 5 distant industries (e.g. free-to-play gaming, low-cost aviation, finance/insurance, luxury concierge, logistics, real estate, open-source).
   - Name the source industry + the exact mechanic adapted to the SaaS.
3. **Inversion & Extreme Constraints** *(4 ideas)*:
   - Answer radical constraints tailored to the chosen lever:
     - *If Revenue goal:* "How could you charge an existing customer **5x more** without adding a single seat?"
     - *If Customers goal:* "How could you acquire customers with **zero ad budget and zero sales team**, purely through product usage?"
4. **Wildcard / Provocateur Role** *(2-4 ideas)*:
   - Deliberately uncomfortable, counter-intuitive, or "too weird to be reasonable" ideas (taming a wild idea often produces genuine differentiation).

---

## Step 5: CONVERGENCE & "Idea Killer" Filter (Shreyas Doshi + Verna + Torres)

Switch hats completely: adopt a **ruthless Investment Committee** lens (skeptical CPO + margin-obsessed CFO + customer who hates paying for one more tool).

1. **Eliminate without mercy** "nice-to-have" ideas that do not solve a #1 problem (Shreyas Doshi's *Customer Problem Stack Ranking*).
2. **Select the top 4-5 gems** (including at least 1 idea from *Wildcard* or *Collision* made pragmatic).
3. For each selected gem, deliver an **actionable brief**:
   - **Concrete concept** (2 plain-English sentences, zero jargon).
   - **Cash & packaging mechanic:** how it brings in money (acquisition / conversion / add-on / higher tier / usage credits) and **who** approves the spend.
   - **Why it stands out:** which competitor blind spot it exploits.
   - **The killer assumption:** the single riskiest belief that could make it fail.
   - **48-hour no-code test:** ultra-fast experiment to validate real willingness to pay before building (*fake door*, pre-sale page, clickable mockup, *Wizard-of-Oz* manual service).

---

## Step 6: Delivery & Next Steps

1. Present a **summary comparison table** of the 4-5 finalists (Name, Lever, Cash Potential, Test Effort, Differentiation Score), followed by the detailed briefs.
2. End with two concrete follow-up options:
   - **Deep-dive one gem:** turn the chosen idea into a mini-spec + ready-to-run 48h validation script.
   - **Cross-Vendor Pooling (Wharton method):** output a compact prompt (including the blacklist and *Verbalized Sampling* directive) that the user can paste into another LLM (Claude, GPT, etc.) to cross-check blind spots across models.
