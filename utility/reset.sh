#!/usr/bin/env bash
# Restores Book.java to its last-committed baseline. Run this between
# tricks (or after a rehearsal) so each trick script starts clean.
set -euo pipefail
cd "$(dirname "$0")/.."

git checkout -- src/main/java/com/example/library/Book.java
echo "Book.java reset to baseline."

if [ -f docs/specs/STYLE.md ]; then
  echo
  echo "Note: docs/specs/STYLE.md still exists (from 99-add-style-guide.sh)."
  echo "This script never touches it -- delete it by hand if you want a"
  echo "full reset:"
  echo "  rm docs/specs/STYLE.md"
fi

git status --short
