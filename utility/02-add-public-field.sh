#!/usr/bin/env bash
# Trick 2: add a PUBLIC field to Book. Proves the cascade -- every real
# consumer of Book goes stale, one hop, while the unrelated
# HealthResource never moves.
set -euo pipefail
cd "$(dirname "$0")/.."

FILE="src/main/java/com/example/library/Book.java"

sed -i 's/public boolean available;/public boolean available;\n\n    \/\/ Added live: a public field. Part of Book'"'"'s real public shape.\n    public int totalCheckouts;/' "$FILE"

echo "=== What changed ==="
git diff -- "$FILE"

cat <<'EOF'

=== Ask CodeOwl next ===

  "is CheckoutService's spec still accurate? what about BookResource
   and OverdueCheckJob?" / "what actually depends on Book?"
    -> get_spec on each file below (or get_callers("...Book.java::Book")
       first, to show the 3 real reference edges before checking each)

  "what about HealthResource?" / "did that change affect everything,
   or just what actually touches Book?"
    -> get_spec on HealthResource.java

Expected -- the real consumers cascade, the bystander doesn't:

| File                  | Status before | Status now | Why                                  |
|------------------------|---------------|------------|----------------------------------------|
| CheckoutService.java   | current       | stale      | changed:dependencies -- reads Book     |
| BookResource.java      | current       | stale      | changed:dependencies -- returns List<Book> |
| OverdueCheckJob.java   | current       | stale      | changed:dependencies -- queries Book   |
| HealthResource.java    | current       | current    | never referenced Book at all           |

CodeOwl names exactly what moved (`changed: ["changed:dependencies"]`)
-- no guessing which file to go re-check by hand.

The point: interface_hash moved because a real public field appeared,
so every direct importer of Book is correctly flagged -- and only
those, not the whole repo.

Run utility/reset.sh before you're done (or before rehearsing again).
EOF
