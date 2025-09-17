# Agent Builder Bundle

**Version**: 2.2.0
**Bundle Type**: Core System Bundle
**Last Updated**: 2025-01-15

## Overview

This is the self-contained Agent Builder bundle - a complete toolkit for creating, editing, validating, and packaging Claude Code agents. This bundle includes all agents, templates, and dependencies needed to run the Agent Builder system.

## Bundle Contents

### 📦 Agents (5)
- **agent-builder-context** - Context gathering and orchestration (NEW - Primary Entry Point)
- **agent-builder** - Interactive agent creation with template auto-application
- **agent-editor** - Agent modification and improvement
- **agent-validator** - Quality and structure validation
- **agent-packager** - Bundle creation with correct install script template

### 📋 Templates (9)
All templates referenced by the agents are included:
- agent-coordination-template.md
- todowrite-integration-template.md
- structured-choice-template.md
- validation-checklist-template.md
- agent-builder-logging-template.md
- operational-protocols-template.md
- proactive-behavior-template.md
- claude-subagent-template.md
- portable-agent-template.md

### 📚 Examples
- sample-subagent.md
- sample-portable-agent/

## What's New in v2.2.0

### 🎯 Enhanced Workflow with agent-builder-context
- **Primary Entry Point**: New orchestrator agent for better context gathering
- **Intelligent Routing**: Automatically directs to the right specialist
- **Template Auto-Application**: Templates now automatically detected and applied
- **Better Handover**: Comprehensive context preserved from Main Claude

### 🔧 Key Improvements
- **agent-builder**: Now automatically scans and applies templates from `/templates/`
- **agent-packager**: Fixed to use correct `install-script-template.sh` with --global/--project modes
- **All Agents**: Enhanced with bidirectional awareness and improved routing

### 📝 Usage Examples
```bash
# Recommended: Use context-aware entry point
"I want to work with agents for [purpose]"

# Still supported: Direct agent access
"I want to create an agent for [purpose]"
"I want to edit my agent"
"I want to validate my agent"
```

## Installation

This bundle supports flexible installation options:

### Install Everything (Default)
```bash
# To current project
./install.sh --project

# Globally for all projects
./install.sh --global
```

### Selective Installation
```bash
# Install only specific agents
./install.sh --only agent-builder --only agent-validator

# Install all except certain agents
./install.sh --exclude agent-editor

# See what's in the bundle
./install.sh --list

# Verify bundle integrity
./install.sh --verify
```

## How This Bundle Works

### Agent Coordination
The agents use intelligent routing with agent-builder-context as the primary entry:
```
    agent-builder-context (Primary Entry Point)
           ↙     ↓     ↘     ↘
    agent-builder  agent-editor  agent-validator  agent-packager
         ↓            ↓              ↓
    agent-validator ←─┘         agent-packager
         ↓
    agent-packager
```

### Smart Features
- **Selective Installation**: Choose exactly which agents you need
- **Automatic Backups**: Preserves existing agents before updating
- **Dependency Management**: All templates and resources included
- **Integrity Verification**: Ensures bundle completeness

## Bundle Structure
```
agent-builder/
├── install.sh              # Smart installer
├── README.md              # This file
├── VERSION                # Bundle version
├── MANIFEST.json          # Component inventory
├── agents/                # All 5 agents
├── templates/             # All 9 templates
├── examples/              # Example agents
└── docs/                  # Additional docs
```

## Differences from Main Project

This bundle is:
- **Self-contained**: Everything needed in one directory
- **Portable**: Move/copy anywhere as a unit
- **Versioned**: Independent version tracking
- **Repository-ready**: Can be its own git repo

The main project README covers:
- Overall Agent Builder concepts
- Installation from source
- Usage philosophy
- Contributing guidelines

This bundle README covers:
- What's in THIS specific bundle
- How to install THIS bundle
- Bundle-specific features

## Troubleshooting

### Bundle Issues
```bash
# Check integrity
./install.sh --verify

# List contents
./install.sh --list

# Verbose installation
./install.sh --verbose --project
```

### Common Problems
- **"Agent not found"**: Check installation path matches Claude Code's agent directory
- **Missing templates**: Run `--verify` to ensure all components present
- **Permission denied**: Make install.sh executable: `chmod +x install.sh`

## Version History

- **2.0.0**: Complete bundle architecture with smart installer
- **1.0.0**: Initial release

## Related Documentation

For complete Agent Builder documentation, see the main project README at:
https://github.toasttab.com/johnconneely-toast/agent-builder

## Support

This bundle is part of the Agent Builder toolkit. For issues or improvements:
- Use agent-validator to check agent quality
- Use agent-editor to modify agents
- Use agent-packager to create new bundles