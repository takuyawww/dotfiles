#!/bin/bash
set -e

INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
  exit 0
fi

# Use relative path from ~/workspace to preserve directory hierarchy
WORKSPACE_ROOT="$HOME/workspace"
if [[ "$CWD" == "$WORKSPACE_ROOT"/* ]]; then
  PROJECT_NAME="${CWD#$WORKSPACE_ROOT/}"
else
  PROJECT_NAME=$(basename "$CWD" 2>/dev/null || echo "unknown")
fi
DEST_DIR="$HOME/workspace/claude-sessions/$PROJECT_NAME"
mkdir -p "$DEST_DIR"

DATE=$(date +%Y-%m-%d)
DEST_FILE="$DEST_DIR/${DATE}_${SESSION_ID}.jsonl"

BRANCH=$(jq -r 'select(.type == "user") | .gitBranch // empty' "$TRANSCRIPT_PATH" | head -1)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

echo "{\"session_id\":\"$SESSION_ID\",\"project\":\"$PROJECT_NAME\",\"branch\":\"$BRANCH\",\"date\":\"$TIMESTAMP\"}" > "$DEST_FILE"
jq -c 'select(.type == "user" or .type == "assistant") | {role: .message.role, content: .message.content}' "$TRANSCRIPT_PATH" >> "$DEST_FILE"