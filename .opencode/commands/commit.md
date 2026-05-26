---
description: git commit and push
subtask: true
---

## 1. Identify Relevant Files

List all modified, added, or deleted files from the current session:

!`git diff --name-only HEAD`

## 2. Categorize Changes

Group the files by small, target features (e.g., "add login validation", "fix sidebar collapse bug", "update README"). Each group should be a single logical change.

## 3. Stage and Commit per Group

For each group, stage the relevant files and commit with a standard commit message:

```
<type>(<scope>): <short summary>

<explanation of WHY from end-user perspective>
```

Use types:
- `feat:` — new feature
- `fix:` — bug fix
- `docs:` — documentation
- `refactor:` — code restructuring
- `style:` — formatting, styling
- `perf:` — performance improvement
- `test:` — adding/fixing tests
- `chore:` — tooling, CI, dependencies
- `ci:` — CI/CD changes
- `tui:` — TUI-specific changes
- `core:` — core library changes
- `wip:` — work in progress

Rules:
- Stage only files related to **this group**
- Commit message must explain **WHY** from an end-user perspective, not **WHAT**
- Be specific — avoid generic messages like "improved agent experience"
- Do **not** use `docs:` prefix unless the change is truly documentation-only
- If there are merge conflicts, **do not fix them** — notify the user

## 4. Push

!`git push`
