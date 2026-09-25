#!/usr/bin/env bash
# Trick 1: add a PRIVATE field to Book. Proves the fold only ever
# watches public surface -- nothing downstream should react.
set -euo pipefail
cd "$(dirname "$0")/.."

FILE="src/main/java/com/example/library/Book.java"

sed -i 's/private String internalNotes;/private String internalNotes;\n\n    \/\/ Added live: a private field. Internal-only, never exposed.\n    private String barcodeId;/' "$FILE"

echo "=== What changed ==="
git diff -- "$FILE"

cat <<'EOF'

=== Ask CodeOwl next ===

  "show me the current shape of Book" / "what fields does Book have
   right now?"
    -> get_source("src/main/java/com/example/library/Book.java::Book")
    -> barcodeId shows up immediately -- re-parsed within ~1s, no
       restart, no re-generation of anything.

  "is CheckoutService's spec still accurate?" / "did adding that field
   break anything downstream?"
    -> get_spec on each file below

Expected -- every real consumer of Book, unaffected:

| File                  | Status before | Status now | Why                          |
|------------------------|---------------|------------|-------------------------------|
| CheckoutService.java   | current       | current    | private field, not the promise |
| BookResource.java      | current       | current    | private field, not the promise |
| OverdueCheckJob.java   | current       | current    | private field, not the promise |
| HealthResource.java    | current       | current    | never referenced Book at all   |

The point: a private field is never part of the public promise, so it
never enters interface_hash -- nothing that depends on Book, real or
otherwise, has any reason to go stale.

Run utility/reset.sh before the next trick.
EOF
