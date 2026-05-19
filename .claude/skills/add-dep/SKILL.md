---
description: Add a missing dependency to Taskfile.yml. Usage: /add-dep <brew-package> <stow-target>
---

The user has found a missing dependency and wants to add it to `Taskfile.yml`.

Arguments: `$ARGUMENTS` — format is `<brew-package> <stow-target>` (e.g. `wget nvim` or `go nvim`).

Steps:
1. Parse the arguments: first token is the brew package name, second is the stow target whose `deps` list should include this new task.
2. Read the current `Taskfile.yml`.
3. Add a new `setup:<brew-package>` task following the existing pattern exactly:
   - `desc` line
   - `cmds` with `brew install <package>`
   - `status` with `command -v <binary>` (use the binary name, which may differ from the package name — e.g. `ripgrep` → `rg`)
4. Add `setup:<brew-package>` to the `deps` list of `stow:<stow-target>`.
5. Confirm what was added.

Follow the idempotent pattern used throughout the file — every `setup:*` task must have a `status` check so it is skipped if already installed.
