# Claude Code Agent Logging System

## Overview
Automatic logging system for all Claude Code subagent tasks, capturing full transcripts and story implementation metrics.

## Features

### Tier 1: Transcript Logging
- Automatic detection of KP4 tickets from git branches
- Structured log directories: `KP4-XXXX/logs/<agent-name>/YYMMDD_HHMMSS_log.txt`
- Full agent execution context
- Automatic transcript export attempts

### Tier 2: Story Implementation Metrics
- **Pre-execution metrics:**
  - Git branch, commit, and status
  - Current modified files count
  - Initial build/test status
  
- **Post-execution metrics:**
  - Completion timestamp
  - Git diff statistics
  - Files modified during execution
  - Final build/test status
  - Lines of code changed

## Setup Status
✅ **Logging script**: `~/.claude/log-agent-task.sh`
✅ **Task hook configured**: In `~/.claude/settings.json`
✅ **Permissions**: Script is executable
✅ **Test run**: Successfully created test logs

## How It Works

1. **Automatic Trigger**: Every time you use a subagent (e.g., `python-backend-developer`), the Task hook fires
2. **Context Capture**: Script records current state, git info, and build status
3. **Background Monitoring**: Continues capturing metrics while agent runs
4. **Transcript Export**: Attempts to export full conversation after completion

## Log Structure Example

```
KP4-2187/
└── logs/
    ├── python-backend-developer/
    │   ├── 250902_142300_log.txt
    │   └── 250902_151500_log.txt
    ├── frontend-developer/
    │   └── 250902_160000_log.txt
    └── tui-measurement-expert/
        └── 250902_170000_log.txt
```

## Log File Contents

Each log contains:
1. **Header**: Timestamp, agent type, ticket, project info
2. **Pre-execution metrics**: Git status, build status
3. **Agent execution marker**
4. **Post-execution metrics**: Changes made, final status
5. **Claude transcript**: Full conversation (if export succeeds)

## Usage

Just use agents normally! Logging happens automatically:

```bash
# In your conversation with Claude:
"Use the python-backend-developer agent to fix the API endpoint"
# → Automatically logs to KP4-XXXX/logs/python-backend-developer/
```

## Analyzing Logs

```bash
# View all logs for current ticket
ls -la KP4-*/logs/*/

# Search for patterns across all logs
grep -r "error" KP4-*/logs/

# Count agent usage
ls KP4-*/logs/*/ | cut -d'/' -f3 | sort | uniq -c

# Find longest-running tasks (by log size)
find KP4-*/logs -name "*.txt" -exec wc -l {} \; | sort -n
```

## Metrics for AI Development Efficiency

Track these metrics over time:
- **Success rate**: Tasks with passing `make check`
- **Code velocity**: Lines changed per agent per story
- **Agent effectiveness**: Which agents complete tasks fastest
- **Iteration count**: Number of agent calls per story
- **Quality indicators**: Test pass rates, lint issues

## Troubleshooting

If logs aren't being created:
1. Check hook is active: `cat ~/.claude/settings.json | grep Task`
2. Verify script permissions: `ls -l ~/.claude/log-agent-task.sh`
3. Test manually: `~/.claude/log-agent-task.sh test-agent test-123 $(pwd)`

## Next Steps

Consider adding:
- OpenTelemetry integration for cross-project analytics
- Automated metrics dashboards
- Agent performance scoring
- Story complexity analysis