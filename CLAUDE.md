# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Agent Builder Project

This repository contains the Agent Builder toolkit - an interactive system for creating high-quality Claude Code subagents and portable web-compatible agents.

### Key Components

- **`.claude/agents/`**: Core agent builder system
  - `agent-builder.md` - Main interactive agent creation specialist
  - `agent-validator.md` - Agent validation and quality checking
  - `agent-packager.md` - Bundle packaging and distribution management

- **`templates/`**: Templates for both output formats
  - `claude-subagent-template.md` - Claude Code subagent format
  - `portable-agent-template.md` - Standalone web agent format

- **`examples/`**: Complete examples showing both formats
  - `sample-subagent.md` - API documentation agent (Claude Code)
  - `sample-portable-agent/` - Code reviewer (portable package)

### Usage

To create new agents, simply say: "I want to create an agent for [specific purpose]"

The agent-builder will automatically activate and guide you through a structured 5-phase creation process with forced todo management for complex operations.

### TODO Document Management

**IMPORTANT**: All agents in this system use comprehensive TODO documents to track complex operations.

- **Location**: `docs/todos/` contains all TODO tracking documents
- **Format**: `YYYY-MM-DD-{task-name}-todo.md`
- **Template**: `templates/todo-template.md` provides the standard structure

**When to Check TODOs**:
1. When resuming work after a break or terminal restart
2. Before starting any agent-related task
3. When context is unclear or you need to remember previous decisions
4. To understand what has been completed and what remains

**Agent TODO Responsibilities**:
- **agent-builder**: Creates TODO when building new agents
- **agent-validator**: Updates TODO with validation results
- **agent-editor**: Primary handler - creates/updates TODOs for all modifications
- **agent-packager**: Includes relevant TODOs in bundles

**TODO Benefits**:
- Maintains context across sessions
- Documents all decisions and changes with file:line references
- Tracks blockers and issues
- Provides clear progress visibility
- Enables seamless handoff between agents