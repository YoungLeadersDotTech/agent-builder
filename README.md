# Agent Builder

> Interactive agent creation toolkit for Claude Code subagents and portable web-compatible agents

## What is Agent Builder?

Agent Builder is a sophisticated toolkit that helps you create high-quality AI agents through a structured 5-phase workflow. It can generate both Claude Code subagents and portable agent packages that work across different AI platforms.

### Key Features

- **🤖 Interactive Creation**: Guided 5-phase workflow for building agents
- **📦 Dual Output**: Create Claude Code subagents AND portable web packages
- **✅ Built-in Validation**: Ensure quality and avoid conflicts
- **📚 Rich Templates**: Professional templates for both formats
- **🔧 Supporting Tools**: Validation and installation specialists

## Quick Start

### Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/YoungLeadersDotTech/agent-builder.git
   cd agent-builder
   ```

2. **Install the Agent Builder system**:
   
   The Agent Builder includes three core subagents that work together to help you create new agents. You need to install these subagents into your Claude Code environment:

   **Option A: Install for current project only**
   ```bash
   # Run the installation script for your current project
   ./scripts/install.sh --project
   ```
   This copies the agent-builder subagents to `.claude/agents/` in your current project.

   **Option B: Install globally for all projects**
   ```bash
   # Run the installation script globally
   ./scripts/install.sh --global
   ```
   This copies the agent-builder subagents to `~/.claude/agents/` so they're available in all your Claude Code projects.

   **Option C: Manual installation**
   ```bash
   # For current project
   mkdir -p .claude/agents
   cp .claude/agents/* /path/to/your/claude-project/.claude/agents/
   
   # For global installation
   mkdir -p ~/.claude/agents
   cp .claude/agents/* ~/.claude/agents/
   ```

   **What gets installed:**
   - `agent-builder.md` - Main interactive agent creation specialist
   - `agent-validator.md` - Agent validation and quality checking
   - `agent-installer.md` - Installation and deployment management

### Usage

In Claude Code, simply say:
```
I want to create a subagent for [specific purpose]
```

The agent-builder will automatically activate and guide you through the 5-phase creation process to build your new subagent.

## The 5-Phase Creation Process

### Phase 1: Discovery
- Understand the agent's role and purpose
- Define core tasks and target audience
- Identify integration with existing agents

### Phase 2: Capabilities  
- Select appropriate Claude Code tools
- Define templates and validation needs
- Specify required knowledge and data

### Phase 3: Personality
- Set communication style and expertise level
- Define guardrails and restrictions
- Establish clear differentiation from other agents

### Phase 4: Deployment Strategy (**NEW**)
**Critical Question**: "Where will this subagent be used?"
- **Claude Code only**: Standard subagent format
- **Web platforms**: Portable package for Gemini, NotebookLM, etc.
- **Both**: Dual output for maximum flexibility

### Phase 5: Integration & Refinement
- Generate appropriate format(s)
- Validate structure and check conflicts
- Install to proper locations

## Output Formats

### Claude Code Subagent
Simple, clean format with YAML frontmatter:
```yaml
---
name: agent-name
description: Clear description for automatic invocation
tools: Read, Write, Edit, Bash
---

Focused system prompt optimized for Claude Code...
```

### Portable Agent Package
Self-contained package for web platforms:
```
agent-name-portable/
├── agent-instructions.md     # Complete standalone instructions
├── templates/               # All required templates
├── examples/               # Usage demonstrations  
└── README.md               # Setup instructions
```

## Available Subagents

- **agent-builder**: Interactive subagent creation specialist (main subagent)
- **agent-validator**: Structure and quality validation
- **agent-installer**: Installation and deployment management

## Examples

- **sample-subagent.md**: API documentation specialist (Claude Code format)
- **sample-portable-agent/**: Code reviewer (portable package format)

## Templates

- **claude-subagent-template.md**: Template for Claude Code subagents
- **portable-agent-template.md**: Template for portable agent packages

## Best Practices

### For Claude Code Subagents
- Keep descriptions specific for automatic invocation
- Choose only necessary tools
- Focus on single responsibility
- Test in your Claude Code environment

### For Portable Packages
- Make instructions self-contained
- Include all necessary templates and resources
- Provide clear setup instructions
- Test across different AI platforms

## Project Structure

```
agent-builder/
├── .claude/
│   └── agents/              # Claude Code subagents
├── templates/               # Agent templates
├── examples/                # Example implementations
├── docs/                    # Additional documentation
└── scripts/                 # Installation utilities
```

## Advanced Usage

### Creating Specialized Agents
The agent-builder can create agents for any domain:
- Code review and quality assurance
- Technical documentation
- API design and testing
- Data analysis and reporting
- Project management
- Security analysis

### Dual-Output Strategy
Perfect for teams with mixed AI platform access:
1. Create Claude Code version for team members with access
2. Generate portable version for broader company use
3. Maintain both versions from single source

## Quality Standards

Every agent created follows these principles:
- **Single Responsibility**: Clear, focused purpose
- **Professional Quality**: Well-crafted system prompts
- **Practical Value**: Solves real problems
- **Proper Integration**: Works well with existing tools
- **Comprehensive Testing**: Validated before deployment

## Contributing

1. Fork the repository
2. Create agents using the agent-builder
3. Test thoroughly in both Claude Code and web platforms
4. Submit pull request with examples

## License

MIT License - See LICENSE file for details

## Support

- **Issues**: Report bugs or request features via GitHub issues
- **Discussions**: Share your created agents and best practices
- **Updates**: Star the repo to get notified of improvements

---

**Ready to build better agents?** Clone this repository and start creating! 🚀