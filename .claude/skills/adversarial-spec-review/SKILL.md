---
name: adversarial-spec-review
description: Use when the user invokes /adversarial-spec-review, or asks to attack, red-team, stress-test, or adversarially review a written design spec before grilling or approval.
---

# Adversarial Spec Review

A fresh-context reviewer tries to prove a written spec wrong. Grilling finds what is undecided; this finds what is false or missing. Run it after the spec is written and before grilling, so its `decide` findings seed the grilling questions.

Arg: spec path. Default: the newest `status: draft` spec under `{design-root}` from `docs/agents/workflow.md` (else `docs/design/specs/`). None found: ask.

## Process

1. **Pin the spec.** Confirm the file exists.
2. **Dispatch one fresh subagent** (`general-purpose`) whose prompt is the spec path, the repo root, and the reviewer brief below, nothing else. No summary of the spec or the design conversation: the reviewer's value is not sharing the author's context.
3. **Relay findings verbatim** under `## Fix` and `## Decide`, then the verdict line. Do not soften, rerank, or rebut them. If you believe a finding is wrong, add one `q:` line under it with your evidence.
4. **Hand off.** `fix` findings: offer to correct the spec. `decide` findings: they are the first round of grilling.

Review only. Do not edit the spec.

## Reviewer brief (paste in full)

> You are reviewing a design spec you did not write. Your job is to find where it is wrong, not to improve its prose or suggest a redesign. Read-only: never edit files.
>
> Read the spec, then the ADRs and learnings docs that touch the same area (locations in the Project settings of `docs/agents/workflow.md` if present, otherwise search `docs/`), and the domain glossary named in `docs/agents/domain.md` if that file exists.
>
> Attack in this order:
> 1. **Claims vs code.** Every statement about current behavior (a class, method, caller list, column, callback, flag, job): open the code and confirm it. Grep for callers the spec missed. For claims about issues, PRs, remotes, or history, check with `git log`, `git remote -v`, and `gh` before calling them unverifiable.
> 2. **Hidden dependencies.** Predicates, enums, flags, and callbacks the design relies on: was their behavior changed recently (`git log -- <path>`)? Does the spec assume a feature-flag state it never states?
> 3. **Failure paths.** Each external call (payment, tax, fraud, fulfillment, AWS), job, and transaction: timeout, error response, retry, partial failure, double submit, re-run. What does the design do in each?
> 4. **State and data.** State-machine transitions, money and tax amounts, existing rows and nulls, backfills, multi-storefront scoping, deploy order (code vs migration), rollback.
> 5. **Trust boundaries.** Authorization, customer data exposure, unvalidated input.
> 6. **Internal consistency.** Sections that contradict each other; goals the design itself breaks; out-of-scope items the design depends on; success criteria or tests that would still pass if the behavior broke.
> 7. **Prior decisions.** Conflicts with an ADR or learning.
>
> Output contract. Each finding is exactly:
> ```
> <bug|risk|q>: <one-sentence defect>
> kind: <fix|decide>   (fix = the spec states something false or omits a fact; decide = needs a human call)
> spec: "<quoted line>" (<section>)
> evidence: <file:line or commit, or "unverified: <what you could not confirm>">
> breaks: <the concrete scenario: input or state → wrong outcome>
> ```
> `bug` = verified wrong. `risk` = plausible failure the spec does not handle. `q` = could not determine.
> Rank most severe first. Skip wording, style, and over-engineering (another review covers that). End with one line: `verdict: sound | sound with fixes | not ready` followed by the counts of bug/risk/q and fix/decide.

## Common mistakes

- Summarising the spec into the dispatch prompt: the reviewer inherits your blind spots. Give the path only.
- Treating `unverified` as `bug`: it is a `q` until someone opens the code.
- Running it after grilling: the `decide` findings then need a second grilling round.
