# Agent Builder Usage Guide

## Getting Started

The Agent Builder uses a structured 5-phase workflow to help you create professional-quality agents. Simply activate it in Claude Code by saying:

```
I want to create an agent for [specific purpose]
```

The agent-builder will automatically activate and guide you through the process.

## The 5-Phase Creation Process

### Phase 1: Discovery
The agent will ask about:
- The specific role or expertise your agent should have
- The 3-5 core tasks it will perform
- Who the target audience is
- How it integrates with existing agents

**Example**:
```
User: "I want to create an agent for API documentation"
Agent: "Let's build an API documentation agent. What specific role should this agent have - technical writer, API analyst, or documentation reviewer?"
```

### Phase 2: Capabilities
Define what your agent can do:
- Which Claude Code tools it needs (Read, Write, Edit, Bash, etc.)
- What templates or documents it should create
- What validation or checking it should perform
- What knowledge or data sources it needs

### Phase 3: Personality
Shape how your agent communicates:
- Communication style (technical, friendly, formal, collaborative)
- Expertise level to demonstrate
- Guardrails and restrictions
- Clear differentiation from other agents

### Phase 4: Deployment Strategy
**New**: Choose where your agent will be used:
- **Claude Code only**: Creates a standard subagent
- **Web platforms only**: Creates a portable package for Gemini, NotebookLM, etc.
- **Both**: Creates dual output for maximum flexibility

### Phase 5: Integration & Refinement
Final steps:
- Generate the appropriate format(s)
- Review and refine based on your feedback
- Validate structure and check for conflicts
- Install to proper location(s)

## Output Formats Explained

### Claude Code Subagent
Perfect for teams using Claude Code:
```yaml
---
name: api-documenter
description: API documentation specialist. Use when creating or improving REST API docs.
tools: Read, Write, Edit, Grep
---

You are an API documentation specialist...
```

Benefits:
- Automatic invocation by Claude Code
- Full integration with Claude Code tools
- Clean, minimal configuration

### Portable Agent Package
Great for broader company use:
```
api-documenter-portable/
├── agent-instructions.md      # Complete standalone instructions
├── templates/                # All required templates
├── examples/                 # Usage demonstrations
└── README.md                 # Setup instructions
```

Benefits:
- Works in any AI platform (Gemini, ChatGPT, NotebookLM)
- Self-contained with all resources
- Easy to share across teams

## Best Practices

### When Creating Agents

1. **Be Specific**: Give agents focused, single responsibilities
2. **Choose Tools Wisely**: Only grant the tools the agent actually needs
3. **Write Clear Descriptions**: Help Claude Code understand when to invoke automatically
4. **Test Both Formats**: If creating dual output, verify both work as expected

### Example Agent Ideas

**Technical Domains**:
- Code reviewer for specific languages
- API documentation specialist  
- Database schema designer
- Security vulnerability analyzer

**Business Domains**:
- Meeting note organizer
- Project plan creator
- Risk assessment specialist
- Compliance checker

**Creative Domains**:
- Content strategy planner
- User story writer
- Technical blog post creator
- Documentation restructurer

## Advanced Usage

### Creating Agent Families
Build related agents that work together:
```
User: "Create a code review agent that works with a security scanner agent"
```

The agent-builder will help design complementary agents that hand off work to each other.

### Company-Specific Agents
Customize for your organization:
```
User: "Create an agent that follows our company's API design standards"
```

Include company-specific templates, checklists, and guidelines in the agent design.

### Multi-Platform Strategy
Use dual output for maximum reach:
```
User: "I want this agent to work in Claude Code for my team and Gemini for other departments"
```

Perfect for organizations with mixed AI platform adoption.

## Troubleshooting

### Agent Not Activating
- Check that the agent file is in the correct location (`.claude/agents/`)
- Verify the YAML frontmatter is properly formatted
- Ensure the description is specific enough for automatic invocation

### Poor Agent Performance
- Use the agent-validator to check structure and quality
- Refine the system prompt to be more specific
- Adjust tool permissions to match the agent's needs

### Conflicts with Existing Agents
- The agent-builder automatically checks for conflicts
- Use unique, descriptive names
- Ensure clear differentiation in the description

## Getting Help

The Agent Builder system includes helpful specialists:

- **agent-validator**: Check agent structure and quality
- **agent-installer**: Handle installation and deployment
- **Templates**: Professional starting points for new agents

Just ask for help with any of these components!

## Examples in Action

### Creating a Database Schema Agent
```
User: "I need an agent that helps design database schemas"

Agent Builder Process:
Phase 1: Role = Database Architect, Tasks = schema design, normalization, optimization
Phase 2: Tools = Read, Write, Edit for schema files and documentation
Phase 3: Technical communication style, expert-level database knowledge  
Phase 4: Claude Code + Portable (team uses both platforms)
Phase 5: Generate both formats, validate, install

Result: Professional database schema agent ready for immediate use
```

This systematic approach ensures every agent you create is well-designed, properly integrated, and immediately useful!