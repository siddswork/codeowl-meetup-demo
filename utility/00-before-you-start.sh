#!/usr/bin/env bash
# Everything to show BEFORE touching any code -- the two live moments
# that come before the staleness tricks (01/02). Doesn't change
# anything; safe to re-run any time, including mid-rehearsal.
set -euo pipefail
cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd)"

cat <<'EOF'
=== Moment 1: read tools, on CodeOwl's OWN repo (not this one) ===

Switch to the codeowl repo for this part. Real questions, sourced
verbatim from setup/USAGE.md's own FAQ (each one was live-verified
against this exact repo when that doc was written):

  "who calls Graph?" / "what breaks if I change Graph's public API?"
    -> get_callers("src/graph.rs::Graph")

  "what does Graph actually contain?" / "what fields and methods does
   Graph have?"
    -> get_symbol("src/graph.rs::Graph")

  "what does graph.rs itself depend on?" / "what does graph.rs import?"
    -> get_callees("src/graph.rs")

  "where are the documentation gaps?" / "what should I document first?"
    -> get_spec_coverage

  "what does search_code actually do?" / "show me search_code's real
   implementation, not just the signature"
    -> get_source (on search_code itself -- get_symbol alone stops at
       the declared shape, get_source returns the real body)

Point: this isn't a toy -- it's the same tool, running on its own
~14,000-node codebase, live, right now, and every one of these
questions has a real, previously-verified answer, not a guess.

EOF

echo "=== Moment 2: this repo -- Library Checkout, a small Quarkus service ==="
echo
cat <<'EOF'
Five files: Book (a Panache entity -- 3 public fields, 1 private),
CheckoutService (business logic), BookResource (3 REST endpoints),
OverdueCheckJob (a @Scheduled job), HealthResource (a genuinely
unrelated liveness endpoint -- used later, in the staleness tricks).
Two entry-point kinds CodeOwl's Quarkus support recognizes: HTTP and
scheduled. Baseline specs are already committed and current for 4
files + the rollup; the feature specs and system spec are left
missing on purpose -- that's what this moment fills in, live.

EOF

echo "--- 1. Show spec coverage ---"
echo "Ask: \"what's the current spec coverage for this repo?\""
echo
cat <<'EOF'
| Status  | Kind    | Item                                 |
|---------|---------|---------------------------------------|
| current | file    | BookResource.java                    |
| current | file    | CheckoutService.java                 |
| current | file    | HealthResource.java                  |
| current | file    | OverdueCheckJob.java                 |
| current | rollup  | rollup:.../library                   |
| missing | feature | feature:http-get-books               |
| missing | feature | feature:http-get-health              |
| missing | feature | feature:http-post-books-id-checkout  |
| missing | feature | feature:http-post-books-id-return    |
| missing | feature | feature:scheduled-flagoverduebooks   |
| missing | system  | system                               |

EOF

echo "--- 2. Generate one feature spec, targeted ---"
echo 'Ask: "generate the spec for feature:http-post-books-id-checkout"'
echo "  -> drives the real get_next_spec_task -> write -> submit_spec"
echo "     loop, live, in front of the room. You pick the target."
echo

echo "--- 3. Generate a small batch, budgeted -- CodeOwl picks the order ---"
echo "Run the slash command:"
echo "  /codeowl-generate --all --budget=2"
echo "  -> a different mode: CodeOwl walks its own priority order (not"
echo "     targeted by you) and stops after 2 real generations. Shows"
echo "     the tool that actually drives a full documentation pass."
echo
echo "Then re-ask for coverage and show the table shrink."
echo
echo "Once that's done: $REPO_ROOT/utility/01-add-private-field.sh"
