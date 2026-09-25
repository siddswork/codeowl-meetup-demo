#!/usr/bin/env bash
# Restores Book.java to its last-committed baseline. Run this between
# tricks (or after a rehearsal) so each trick script starts clean.
set -euo pipefail
cd "$(dirname "$0")/.."

git checkout -- src/main/java/com/example/library/Book.java
echo "Book.java reset to baseline."
git status --short
