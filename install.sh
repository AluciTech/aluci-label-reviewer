#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/AluciTech/aluci-label-reviewer/main"
TOOL="${1:-}"

usage() {
  echo "Usage: curl -fsSL <url>/install.sh | bash -s -- <tool>"
  echo ""
  echo "Tools:"
  echo "  claude     Install for Claude Code (.claude/commands/)"
  echo "  opencode   Install for OpenCode (.opencode/commands/)"
  echo "  all        Install for both"
}

install_agents() {
  echo "Downloading AGENTS.md..."
  curl -fsSL "$BASE_URL/AGENTS.md" -o AGENTS.md
}

install_claude() {
  mkdir -p .claude/commands
  echo "Downloading .claude/commands/pre-review.md..."
  curl -fsSL "$BASE_URL/.claude/commands/pre-review.md" -o .claude/commands/pre-review.md
}

install_opencode() {
  mkdir -p .opencode/commands
  echo "Downloading .opencode/commands/pre-review.md..."
  curl -fsSL "$BASE_URL/.opencode/commands/pre-review.md" -o .opencode/commands/pre-review.md
}

case "$TOOL" in
  claude)
    install_agents
    install_claude
    ;;
  opencode)
    install_agents
    install_opencode
    ;;
  all)
    install_agents
    install_claude
    install_opencode
    ;;
  *)
    usage
    exit 1
    ;;
esac

echo "Done! Run /pre-review from your coding agent to start a pre-review."
