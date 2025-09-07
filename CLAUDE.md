# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Agent Builder Project

This repository contains the Agent Builder toolkit - an interactive system for creating high-quality Claude Code subagents and portable web-compatible agents.

### Key Components

- **`.claude/agents/`**: Core agent builder system
  - `agent-builder.md` - Main interactive agent creation specialist
  - `agent-validator.md` - Agent validation and quality checking
  - `agent-installer.md` - Installation and deployment management

- **`templates/`**: Templates for both output formats
  - `claude-subagent-template.md` - Claude Code subagent format
  - `portable-agent-template.md` - Standalone web agent format

- **`examples/`**: Complete examples showing both formats
  - `sample-subagent.md` - API documentation agent (Claude Code)
  - `sample-portable-agent/` - Code reviewer (portable package)

### Usage

To create new agents, simply say: "I want to create an agent for [specific purpose]"

The agent-builder will automatically activate and guide you through a structured 5-phase creation process with forced todo management for complex operations.