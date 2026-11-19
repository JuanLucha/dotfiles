# Code Now Skill Context

Context for the design and implementation of the "code_now" skill, which delegates programming tasks to lighter subagents following the canonical DeepSeek pattern (Leader / Worker / Reviewer).

## Model ownership

Each role's model and effort variant live in its agent definition
(`agents/agents/coder.md` → low effort, `agents/agents/reviewer.md` → high effort).
The skill never lists model IDs; the fallback ladder is defined in `SKILL.md`.

Principle: **the high-effort reviewer thinks and judges; the low-effort coder executes**.

## Language

**Leader** (Orchestrator):
The parent agent running at high effort. Analyzes requirements, researches the codebase, decomposes work (WBS), performs the final verdict, and escalates hard bugs.
_Avoid_: Supervisor, Manager, Main Agent

**Micro-plan** (task package):
A highly compressed, directive prompt the Leader sends to a Worker. Contains no source code, only precise instructions on which files to read and what logic to implement — optimizing token usage.
_Avoid_: Detailed spec, Code dump

**Worker** (Coder):
A low-effort subagent invoked by the Leader to implement a specific part of the code guided by a Micro-plan. Multiple Workers run in parallel, each in a short independent context.
_Avoid_: Slave, Sub-model

**Reviewer**:
A high-effort agent (or the Leader itself for small changes) that reviews each Worker's output and returns a structured 0/1 verdict with error codes + line ranges.

**Validation Loop**:
The iterative process where a Worker runs tests/linters on its own work. On failure, it retries with the error output plus hints until the code compiles and passes.
_Avoid_: Feedback loop, Review process

**Safety Valve**:
If a Worker fails after 2 corrections (3rd failure), stop retrying — follow the skill's fallback ladder, then escalate the error logs and context to the Leader for direct intervention.
