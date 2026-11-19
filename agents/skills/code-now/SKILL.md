---
name: code-now
description: Orchestrates a token-optimized coding loop following the canonical DeepSeek pattern: a high-effort Leader (analysis, WBS decomposition, final verdict) delegates parallel coding to low-effort Workers, with a high-effort Reviewer returning a structured 0/1 verdict. Models live in the agent definitions, never in this skill. Use to implement features or fixes autonomously while minimizing cost.
---

# Code Now Skill (Leader / Worker / Reviewer with Safety Valve)

## Core Concept

The canonical DeepSeek three-role pattern: separate **reasoning** (think & judge) from **execution** (read & write code), so each model does only what it's good at and no token is wasted.

## Models — the agent definitions are the single source of truth

The model and the effort variant for each role live in the agent frontmatter, which the
harness applies on every dispatch:

- `~/.config/opencode/agents/coder.md` → `model: <provider>/<model>#low`
- `~/.config/opencode/agents/reviewer.md` → `model: <provider>/<model>#high`

This skill must **never** list model IDs: they change daily and a copy here silently rots.
If a role needs a different model, edit that agent file — nothing else.

**Preflight (once per run, before the first `subagent` call).** Read both agents' `model:`
values, verify each one is currently offered (with the models tool or `opencode models`),
and state the resolved pair in your first message to the user. If either value is missing,
malformed, or no longer offered: **stop and ask**. Never substitute silently.

**Agent definitions are read when the opencode server starts.** Editing an agent's `model:`
does not affect a session that is already running — the old value keeps being used until the
server/UI restarts, and the failure looks exactly like a wrong model choice. So the preflight
must confirm the model the *dispatched agent reports it is running as* (ask it in a one-line
probe when the config was just edited), not merely what the file says.

**Fallback ladder, only after a dispatch fails with an unavailable/quota/provider error.**
1. The same model ID with the `-free` variant, keeping the effort (`#low`/`#high`).
2. `deepseek/deepseek-flash#<same effort>`.
3. Stop and report the failure with the error text.
Overriding `model:` on the `subagent` call is allowed **only** for this ladder, and every
substitution must be named in the final report.

**Always carry the variant.** `#low` for the coder, `#high` for the reviewer. A dispatch
without a variant, or one that inherits the parent session's model, is a bug: the roles
are separated by effort, not by luck.

> **Principle**: the reviewer (high effort) does not operate tools — it thinks and judges. The coder (low effort) does not deep-reason — it executes precise instructions.

## Execution Workflow

Strictly follow these steps when the skill is activated:

1. **Analysis & Decomposition (Leader)**:
   - Analyze the user's request; clarify requirements if incomplete (focused questions, then proceed with sensible defaults).
   - Research the codebase to map the exact files involved.
   - Decompose into independent tasks (WBS), marking dependencies and parallel groups.
   - Decide the **mode** (pro or high effort vs flash or low effort) for this task.

2. **Parallel Coding (Workers)**:
   - Launch one Worker per independent task using the harness's `subagent` tool with `agent: "coder"` (its agent definition supplies the model and effort) and a compressed **micro-plan**: precise files to read + logic to implement, no source-code dump. Run independent tasks in parallel; keep coupled tasks (same files or shared contracts) in a single Worker or run them sequentially. Do not pass `model:` on a normal dispatch; only the fallback ladder may override it.
   - Each Worker writes code and validates itself via terminal commands (linters, tests, builds) before reporting.

3. **Review & Verdict (Reviewer)**:
   - Launch the Reviewer (via the harness's `subagent` tool, `agent: "reviewer"`; its agent definition supplies the model and effort) against **every** Worker's output, returning a structured 0/1 verdict with error codes/lines. The ONLY exception is a change that cannot affect correctness (a one-line copy/text edit or a comment) — and even then, say so explicitly. Any change touching Rust, WASM, build config, shared types/contracts, or a state/schema is **never** "small" and always goes through the Reviewer. Do not substitute your own build/test checks for the Reviewer's verdict.
   - **SAFETY VALVE**: if a Worker fails after 2 corrections (i.e., on the 3rd failure), do NOT retry — first try the fallback model, then immediately report the failure, error logs, and context to the Leader (Pro) for escalation.

4. **Escalation & Final Verdict (Leader)**:
   - **If Escalated**: the Reviewer/Worker reports a stuck task. You (Leader) step in, read the context, and write the fix directly with your own tools.
   - **If Green**: perform the final verdict. If there are architectural flaws, send a follow-up `subagent` session (pass the previous `sessionID`) to the Reviewer/Worker with the feedback and send them back to work.

5. **Closure**:
   - Notify the user the task is complete with a brief summary of changes.
   - **Crucial**: if the Safety Valve fired and you (Leader) fixed code manually, say so explicitly (e.g., "Note: I had to intervene manually to fix X because the agents got stuck").

## Token Optimization Notes

- **Role separation**: the reviewer never receives tool definitions; the worker receives precise task packages, not full conversation history.
- **Create-and-destroy Workers**: Workers are spawned, run, and destroyed without inheriting the Leader's context.
- **Structured verdicts**: the Reviewer returns a 0/1 verdict (optionally with error codes/lines), not long prose.
- **Parallel independent tasks**: total cost ≈ O(n) instead of O(n²) by keeping each Worker's context short.
