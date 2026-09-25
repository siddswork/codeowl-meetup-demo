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

1. "show me the current shape of Book"
   -> get_source on "src/main/java/com/example/library/Book.java::Book"
   -> barcodeId shows up immediately (re-parsed within ~1s, no restart)

2. "is CheckoutService's spec still accurate?"
   -> get_spec on "src/main/java/com/example/library/CheckoutService.java"
   -> expect: status "current" -- UNCHANGED, even though Book's own
      source just moved. Same for BookResource.java and
      OverdueCheckJob.java.

The point: a private field is never part of the public promise, so it
never enters interface_hash -- nothing that depends on Book has any
reason to go stale.

Run utility/reset.sh before the next trick.
EOF
