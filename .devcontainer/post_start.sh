#!/bin/sh
set -e
echo ""
echo "‼️ Run User-level startup scripts."

# Find the directory where THIS script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "Retrieving required repositories into ../repos/"

$SCRIPT_DIR/.devcontainer/get_git_repo.sh bacchanal

echo ""
echo "✅ Running of User-level startup scripts complete."
