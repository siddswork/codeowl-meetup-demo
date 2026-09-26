#!/usr/bin/env bash
# Optional extra (numbered 99 on purpose -- not part of the core 00/01/02
# sequence). Adds docs/specs/STYLE.md live and shows it. STYLE.md has no
# required format at all -- CodeOwl never parses it (confirmed in
# spec.rs's own tests: it's explicitly exempt from the file-spec
# frontmatter convention), and /codeowl-generate's own instructions just
# say "read it, follow it for tone" -- this shape is a convention, not
# a requirement.
set -euo pipefail
cd "$(dirname "$0")/.."

FILE="docs/specs/STYLE.md"

cat > "$FILE" <<'STYLE'
# Spec style for this repo

/codeowl-generate reads this before writing any spec here. It sets
audience and tone -- not structure. The headings and everything else
in the command still apply.

## Who the reader is

A librarian running the front desk -- has never seen code, doesn't
know what an API or an endpoint is, and never will need to.

## Rules

1. `## Summary` / `### Summary` may never use these words, even once:
   REST, HTTP, endpoint, API, class, method, field, boolean, request,
   response, service, entity. If the natural sentence needs one of
   these, replace it with what actually happens at the desk instead.

2. Frame every `## Summary` as something happening at the checkout
   desk, not something happening in code. Not "handles a POST request
   to mark a book unavailable" -- "when someone checks a book out, the
   system marks it as no longer available for the next person."

3. `### Behavior` stays fully technical -- HTTP verbs, status codes,
   the real method names. Don't soften this half at all.

## Why the contrast matters

Rule 3 is deliberate, not an oversight: the point is one document,
two readers. A librarian reads `## Summary` and stops there. A
developer or an agent needs `### Behavior` too. Same file, same
spec_hash, two audiences -- that's the thing to point at live, not
a before/after comparison.
STYLE

echo "=== New file ==="
cat "$FILE"

cat <<'EOF'

=== Ask CodeOwl next ===

  "what's still missing?" / "show me the coverage table again"
    -> get_spec_coverage -- pick any feature (or the system spec)
       still `missing`

  "generate the spec for <that id>"
    -> the NEW spec's ## Summary should read like something you'd
       hand a librarian; ### Behavior right below it stays fully
       technical -- same file, same commit, two readers.

Compare it against a spec generated earlier in the demo (before this
file existed) -- that's the visible before/after, in the same repo.

No reset script for this one -- it's a real, permanent addition, not
a trick. Delete docs/specs/STYLE.md by hand if you want it gone.
EOF
