#!/usr/bin/env bash
# One-time setup: writes .vscode/mcp.json for VS Code + GitHub Copilot
# (Agent mode), pointing at the codeowl binary. Assumes the layout
# this demo was built for: a folder (e.g. "demo/") containing both
# the codeowl repo and this repo side by side --
#
#   demo/
#     codeowl/
#     codeowl-meetup-demo/   <- this repo
#
# Machine-specific output (.vscode/mcp.json is gitignored) -- run this
# once per machine you demo from, not something committed and reused.
set -euo pipefail
cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd)"
DEMO_PARENT="$(dirname "$REPO_ROOT")"
CODEOWL_REPO="$DEMO_PARENT/codeowl"

if [ ! -d "$CODEOWL_REPO" ]; then
  echo "Error: expected the codeowl repo as a sibling folder at:"
  echo "  $CODEOWL_REPO"
  echo "If your layout differs, edit CODEOWL_REPO in this script."
  exit 1
fi

BINARY="$CODEOWL_REPO/target/release/codeowl"
if [ ! -x "$BINARY" ]; then
  BINARY="$CODEOWL_REPO/target/debug/codeowl"
fi
if [ ! -x "$BINARY" ]; then
  echo "Error: no codeowl binary found at either:"
  echo "  $CODEOWL_REPO/target/release/codeowl"
  echo "  $CODEOWL_REPO/target/debug/codeowl"
  echo "Build it first:"
  echo "  cd $CODEOWL_REPO && cargo build --release"
  exit 1
fi

mkdir -p .vscode
cat > .vscode/mcp.json <<JSON
{
  "servers": {
    "codeowl": {
      "type": "stdio",
      "command": "$BINARY",
      "args": ["serve", "\${workspaceFolder}"]
    }
  }
}
JSON

echo "Wrote .vscode/mcp.json:"
cat .vscode/mcp.json
echo
echo "Next: open this repo in VS Code (with GitHub Copilot, Agent mode),"
echo "Command Palette -> 'MCP: List Servers' -> Start. Or just reload"
echo "the window -- VS Code picks up .vscode/mcp.json automatically and"
echo "shows a Start codelens above the server block."
