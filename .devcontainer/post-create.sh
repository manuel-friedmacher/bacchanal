#!/bin/sh
set -e

echo ""
echo "‼️ User-level configuration started."

if command -v claude >/dev/null 2>&1; then
    claude update
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

#echo ""
#echo "Create required directory structure for repositories into ../repos/"
#sudo mkdir -p ../repos
#sudo chown vscode:vscode ../repos

#SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
#sudo chown vscode:vscode "$SCRIPT_DIR/get_git_repo.sh"
#sudo chmod +x "$SCRIPT_DIR/get_git_repo.sh"

echo ""
echo "✅ User-level configuration complete."
