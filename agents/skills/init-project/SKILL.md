---
name: init-project
description: Injects a base CONTEXT.md into the current repository to establish the Local Context of the project. Use this whenever you start working on a new repository or project to separate global rules from local ones.
---

Create a file named `CONTEXT.md` at the root of the current workspace. It acts as the domain glossary and architectural decision record (Local Context) exclusive to this project.

If the file already exists, do not overwrite it. Inform the user that the project already has a `CONTEXT.md`.

Replace `[Project Name]` with the actual name of the root folder and create the file with this exact content:

---

# [Project Name] - Local Context

This file defines the domain glossary specific to this project and the local rules (frameworks, architectural conventions) that override or complement the system's Universal Standards.

## Domain Glossary (Language)

_Define the critical terms of your business logic (Domain-Driven Design) here._

**ExampleTerm**:
Definition of what this is in the context of this project.
_Avoid_: Confusing alternative terms.

## Architecture and Stack

- **Main Stack:** (e.g., Next.js, FastAPI, etc.)
- **Styling Strategy:** (e.g., Vanilla CSS, Tailwind)
- **Database:** (e.g., PostgreSQL, Supabase)
- **Specific Conventions:** (Any coding rules that only apply to this repo and aren't in your Universal Standards).
