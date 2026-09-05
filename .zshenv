# GitHub MCP plugin (~/.claude/plugins/.../github/.mcp.json) reads this at Claude Code startup.
# .zshenv runs before /etc/zprofile's path_helper, so /opt/homebrew/bin isn't on PATH yet.
if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ] && [ -x /opt/homebrew/bin/gh ]; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$(/opt/homebrew/bin/gh auth token 2>/dev/null)"
fi
