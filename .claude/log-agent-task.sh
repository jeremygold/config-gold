#!/bin/bash

# Claude Code Agent Task Logger with Story Implementation Metrics
# Usage: Called automatically by Task hook
# Args: $1=AGENT_TYPE, $2=TASK_ID, $3=PROJECT_DIR

set -euo pipefail

AGENT_TYPE="${1:-unknown}"
TASK_ID="${2:-unknown}"
PROJECT_DIR="${3:-$(pwd)}"

# Change to project directory for git operations
cd "$PROJECT_DIR" 2>/dev/null || {
    echo "Warning: Could not change to project directory: $PROJECT_DIR" >&2
    PROJECT_DIR="$(pwd)"
}

# Detect KP4 ticket from git branch or directory name
TICKET=""
if git rev-parse --git-dir >/dev/null 2>&1; then
    TICKET=$(git branch --show-current 2>/dev/null | grep -o 'KP4-[0-9]\+' || echo "")
fi

# Fallback: extract from directory path
if [[ -z "$TICKET" ]]; then
    TICKET=$(echo "$PROJECT_DIR" | grep -o 'KP4-[0-9]\+' || echo "")
fi

# Final fallback: use session-based naming
if [[ -z "$TICKET" ]]; then
    TICKET="agent-logs"
fi

# Create structured logging directory with error handling
LOG_DIR="$PROJECT_DIR/$TICKET/logs/$AGENT_TYPE"
if ! mkdir -p "$LOG_DIR" 2>/dev/null; then
    # Fallback to .claude directory if project directory fails
    LOG_DIR="$HOME/.claude/logs/$TICKET/$AGENT_TYPE"
    mkdir -p "$LOG_DIR" || {
        echo "Error: Cannot create log directory" >&2
        exit 1
    }
fi

# Generate timestamped log file
TIMESTAMP=$(date +"%y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/${TIMESTAMP}_log.txt"

# === TIER 1: Basic Task Logging ===
echo "=== CLAUDE CODE AGENT TASK LOG ===" > "$LOG_FILE"
echo "Timestamp: $(date -Iseconds)" >> "$LOG_FILE"
echo "Agent: $AGENT_TYPE" >> "$LOG_FILE"
echo "Task ID: $TASK_ID" >> "$LOG_FILE"
echo "Ticket: $TICKET" >> "$LOG_FILE"
echo "Project: $PROJECT_DIR" >> "$LOG_FILE"
echo "Host: $(hostname)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# === TIER 2: Story Implementation Metrics (Pre-execution) ===
echo "=== PRE-EXECUTION METRICS ===" >> "$LOG_FILE"

# Git context
if git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Git Branch: $(git branch --show-current 2>/dev/null || echo 'detached')" >> "$LOG_FILE"
    echo "Git Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'unknown')" >> "$LOG_FILE"
    echo "Git Status:" >> "$LOG_FILE"
    git status --porcelain 2>/dev/null | head -20 >> "$LOG_FILE" || echo "  (no changes)" >> "$LOG_FILE"
    
    # Count current changes
    MODIFIED_FILES=$(git status --porcelain 2>/dev/null | wc -l | xargs)
    echo "Modified Files Count: $MODIFIED_FILES" >> "$LOG_FILE"
else
    echo "Git: Not a git repository" >> "$LOG_FILE"
fi

# Current make check status
echo "" >> "$LOG_FILE"
echo "Pre-execution Build Status:" >> "$LOG_FILE"
if [[ -f "$PROJECT_DIR/Makefile" ]]; then
    timeout 30s make --no-print-directory -C "$PROJECT_DIR" check 2>&1 | tail -10 >> "$LOG_FILE" || echo "  Build check failed or timed out" >> "$LOG_FILE"
else
    echo "  No Makefile found" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"
echo "=== AGENT EXECUTION BEGINS ===" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Function to capture post-execution metrics
capture_post_metrics() {
    local log_file="$1"
    
    echo "" >> "$log_file"
    echo "=== POST-EXECUTION METRICS ===" >> "$log_file"
    echo "Completion Time: $(date -Iseconds)" >> "$log_file"
    
    # Git changes made during execution
    if git rev-parse --git-dir >/dev/null 2>&1; then
        echo "" >> "$log_file"
        echo "Changes Made:" >> "$log_file"
        git diff --stat HEAD 2>/dev/null >> "$log_file" || echo "  No git changes" >> "$log_file"
        
        echo "" >> "$log_file"
        echo "File Modifications:" >> "$log_file"
        git status --porcelain 2>/dev/null | head -20 >> "$log_file" || echo "  No modifications" >> "$log_file"
        
        # Final modified files count
        FINAL_MODIFIED=$(git status --porcelain 2>/dev/null | wc -l | xargs)
        echo "Final Modified Files Count: $FINAL_MODIFIED" >> "$log_file"
        
        # Lines of code changed (if committed)
        if [[ $(git log --oneline -1 2>/dev/null | wc -l | xargs) -gt 0 ]]; then
            echo "" >> "$log_file"
            echo "Recent Commit Stats:" >> "$log_file"
            git show --stat HEAD 2>/dev/null | tail -10 >> "$log_file" || echo "  No recent commits" >> "$log_file"
        fi
    fi
    
    # Post-execution build status
    echo "" >> "$log_file"
    echo "Post-execution Build Status:" >> "$log_file"
    if [[ -f "$PROJECT_DIR/Makefile" ]]; then
        timeout 60s make --no-print-directory -C "$PROJECT_DIR" check 2>&1 | tail -15 >> "$log_file" || echo "  Build check failed or timed out" >> "$log_file"
    else
        echo "  No Makefile found" >> "$log_file"
    fi
    
    echo "" >> "$log_file"
    echo "=== CLAUDE TRANSCRIPT ===" >> "$log_file"
}

# Schedule post-metrics capture and transcript export
{
    # Wait for task to complete (detect when Claude stops being active)
    sleep 5
    
    # Multiple attempts to capture post-metrics and transcript
    for attempt in 1 2 3; do
        sleep $((attempt * 3))  # 3, 6, 9 second delays
        
        capture_post_metrics "$LOG_FILE"
        
        # Try to export transcript
        if command -v claude >/dev/null 2>&1; then
            claude export --format=text 2>/dev/null >> "$LOG_FILE" || echo "Transcript export failed (attempt $attempt)" >> "$LOG_FILE"
        elif [[ -n "${CLAUDE_CODE_SESSION_ID:-}" ]]; then
            echo "CLAUDE_CODE_SESSION_ID: $CLAUDE_CODE_SESSION_ID" >> "$LOG_FILE"
            echo "(Manual export may be needed: /export)" >> "$LOG_FILE"
        else
            echo "(Manual transcript export needed: /export)" >> "$LOG_FILE"
        fi
        
        # If file has substantial content, we're done
        if [[ $(wc -l < "$LOG_FILE" 2>/dev/null || echo 0) -gt 50 ]]; then
            break
        fi
    done
} > /dev/null 2>&1 &

# Log creation notification (suppress background PID)
echo "Agent logging started: $LOG_FILE" >&2

# Exit immediately to prevent timeout
exit 0