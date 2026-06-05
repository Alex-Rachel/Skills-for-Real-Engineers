#!/usr/bin/env bash
# Block dangerous git operations from Claude Code
# This script is meant to be used as a PreToolUse hook for the Bash tool

# Read the proposed command from the TOOL_INPUT environment variable
INPUT="${TOOL_INPUT:-}"

# Check for dangerous git operations
DANGEROUS_PATTERNS=(
  "git push --force"
  "git push -f"
  "git push --force-with-lease"
  "git reset --hard"
  "git clean"
  "git checkout ."
  "git restore ."
  "git rebase"
  "git branch -D"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$INPUT" | grep -qE "$pattern"; then
    echo "❌ BLOCKED: Dangerous git operation detected: $pattern"
    exit 2
  fi
done

# Allow the command
exit 0
