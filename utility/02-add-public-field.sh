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

1. "is CheckoutService's spec still accurate? what about BookResource
    and OverdueCheckJob?"
   -> get_spec on each file
   -> expect: all three "stale", changed: ["changed:dependencies"] --
      CodeOwl names exactly what moved, no guessing required.

2. "what about HealthResource?"
   -> get_spec on "src/main/java/com/example/library/HealthResource.java"
   -> expect: still "current" -- it never referenced Book at all, so
      the cascade has nothing to reach it through.

The point: interface_hash moved because a real public field appeared,
so every direct importer of Book is correctly flagged -- and only
those, not the whole repo.

Run utility/reset.sh before the next trick.
EOF
