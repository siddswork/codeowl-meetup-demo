#!/usr/bin/env bash
# Everything to show BEFORE touching any code -- the two live moments
# that come before the staleness tricks (01/02). Doesn't change
# anything; safe to re-run any time, including mid-rehearsal.
set -euo pipefail
cd "$(dirname "$0")/.."

cat <<'EOF'
=== Moment 1: read tools, on CodeOwl's OWN repo (not this one) ===

Switch to the codeowl repo for this part. Ask, e.g.:
  "who calls Graph?"          -> get_callers("src/graph.rs::Graph")
  "what does search_code do?" -> get_source on its own function

Point: this isn't a toy -- it's the same tool, running on its own
~14,000-node codebase, live, right now.

EOF

echo "=== Moment 2: a real spec already sitting in THIS repo ==="
echo "(committed, human-readable, no tool needed to read it)"
echo
cat docs/specs/src/main/java/com/example/library/BookResource.java.md
echo
echo "Note the 'Depends on' list: Book and CheckoutService -- both"
echo "resolved automatically, from real code, not written by hand."
echo

echo "=== Moment 3: what's still missing, live ==="
echo "(current coverage -- 4 files + the rollup are done; 5 things aren't)"
echo
cat <<'EOF'
  current  file     BookResource.java
  current  file     CheckoutService.java
  current  file     HealthResource.java
  current  file     OverdueCheckJob.java
  current  rollup   rollup:src/main/java/com/example/library
  missing  feature  feature:http-get-books
  missing  feature  feature:http-get-health
  missing  feature  feature:http-post-books-id-checkout
  missing  feature  feature:http-post-books-id-return
  missing  feature  feature:scheduled-flagoverduebooks
  missing  system   system

Ask CodeOwl: "generate the spec for feature:http-post-books-id-checkout"
  -> drives the real get_next_spec_task -> write -> submit_spec loop,
     live, in front of the room. Then re-run get_spec_coverage and
     show it move from missing to current.

EOF

echo "Once that's done: ./utility/01-add-private-field.sh"
