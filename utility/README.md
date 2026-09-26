# Demo playbook

## 0. One-time setup: `./utility/mcp_setup.sh`

Writes `.vscode/mcp.json` for VS Code + GitHub Copilot (Agent mode).
Assumes this repo and the `codeowl` repo sit side by side in the same
parent folder (e.g. `demo/codeowl/` and `demo/codeowl-meetup-demo/`).
Auto-detects the sibling `codeowl` repo and its built binary (release,
falling back to debug). Machine-specific output — `.vscode/mcp.json`
is gitignored on purpose, run this fresh on whichever machine you
demo from, not something committed and reused. `.mcp.json` (Claude
Code's own format — different schema, `mcpServers` not `servers`) is
gitignored the same way, for the same reason.

Run these in order during the live demo. Each script prints something
concrete (a real spec, a `git diff`, current coverage) plus the exact
question to ask CodeOwl next, so nothing has to be memorized.

1. **`./utility/00-before-you-start.sh`** — read tools on CodeOwl's
   own repo (a reminder, switch repos for this part), a real committed
   spec from this repo, and the current coverage state (4 files + the
   rollup `current`; 5 feature specs + the system spec still
   `missing`, on purpose).

2. **Generate a spec live, on this repo.** Ask CodeOwl to generate
   `feature:http-post-books-id-checkout` and watch the real
   `get_next_spec_task` → write → `submit_spec` loop happen. Re-run
   coverage after and show it move from `missing` to `current`.

3. **`./utility/01-add-private-field.sh`** — adds a private field to
   `Book`. Shows the diff, then: nothing downstream goes stale. Not
   even `Book`'s own siblings.

4. **`./utility/reset.sh`**

5. **`./utility/02-add-public-field.sh`** — adds a public field to
   `Book`. Shows the diff, then: `BookResource`, `CheckoutService`,
   `OverdueCheckJob` all go `stale` with `changed: ["changed:dependencies"]`.
   `HealthResource` — the one file with no real connection to `Book` —
   stays `current`.

6. **`./utility/reset.sh`** before you're done (or before the next
   rehearsal), so the repo is back to a clean, committed baseline.

Every prediction above was verified end to end against the real graph
before this playbook was written — not just asserted.

## Optional extra (numbered 99, not part of the core sequence)

**`./utility/99-add-style-guide.sh`** — adds `docs/specs/STYLE.md`
live: a spec style guide aimed at a librarian, not a developer.
`STYLE.md` has no required format at all (confirmed in `spec.rs`'s own
tests — it's exempt from the file-spec frontmatter convention, never
parsed, just read as plain instructions before writing). Only worth
running if there's time: generate any still-`missing` feature after
adding it, and its `## Summary` reads for a librarian while
`### Behavior` right below it stays fully technical — same file, same
commit, two readers, the exact claim the `trust` slide already makes.
No reset script for this one; it's a real addition, not a trick.
