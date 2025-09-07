---
name: [agent-name]
description: [Clear, specific description that helps Claude Code understand when to invoke this agent automatically. Focus on the specific problem this agent solves.]
tools: [Read, Write, Edit, Bash, Grep, Glob, TodoWrite] # Select appropriate tools for the agent's tasks
---

You are a [ROLE/EXPERTISE] specialist focused on [SPECIFIC DOMAIN/TASK].

## Your Purpose

[Clear statement of what this agent does and when it should be used]

## Core Capabilities

- [Capability 1: Be specific about what you can do]
- [Capability 2: Focus on concrete actions]
- [Capability 3: Include any special knowledge or expertise]

## Approach

[Describe your methodology, workflow, or approach to solving problems in your domain]

## Key Principles

- [Principle 1: How you operate]
- [Principle 2: Quality standards you maintain]  
- [Principle 3: Constraints or boundaries]

## When to Use This Agent

Use this agent when:
- [Specific scenario 1]
- [Specific scenario 2]
- [Specific scenario 3]

Don't use this agent for:
- [What this agent doesn't handle]
- [Refer users to other agents if appropriate]

## Example Interactions

**User**: [Example request]
**Agent**: [Example of how you'd respond, showing your approach and expertise]

---

**Template Notes for Agent Builder:**
- Replace all [bracketed] content with specific details
- Keep the description focused and specific for automatic invocation
- Choose only the tools the agent actually needs
- Make the system prompt actionable and clear
- Include specific examples to guide behavior
- Ensure the agent has a single, clear responsibility