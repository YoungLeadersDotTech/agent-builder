# Agent Builder

> Interactive agent creation toolkit for Claude Code subagents and portable web-compatible agents

## What is Agent Builder?

Agent Builder is a sophisticated toolkit that helps you create high-quality AI agents through a structured 5-phase workflow. It can generate both Claude Code subagents and portable agent packages that work across different AI platforms.

### Key Features

- **🤖 Interactive Creation**: Guided 5-phase workflow for building agents
- **📦 Dual Output**: Create Claude Code subagents AND portable web packages
- **💬 Freeform Input**: Accept voice dictation, unstructured thoughts, and "word vomit"
- **🌐 Platform Awareness**: Research-backed optimization for ChatGPT, Gemini, NotebookLM, etc.
- **📋 Structured Templates**: Professional 8-section format for consistency and quality
- **✏️ Agent Editing**: Modify and improve existing agents with safety-first workflows
- **✅ Built-in Validation**: Ensure quality and avoid conflicts
- **🔧 Supporting Tools**: Validation, installation, and editing specialists

## Quick Start

### Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/youngleadersdottech/agent-builder.git
   cd agent-builder
   ```

2. **Install the Agent Builder system**:
   
   The Agent Builder includes three core subagents that work together to help you create new agents. You need to install these subagents into your Claude Code environment:

   **Option A: Install for current project only**
   ```bash
   # Run the installation script for your current project
   ./scripts/agent-builder-install.sh --project
   ```
   This copies the agent-builder subagents to `.claude/agents/` in your current project.

   **Option B: Install globally for all projects**
   ```bash
   # Run the installation script globally
   ./scripts/agent-builder-install.sh --global
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
   - `agent-editor.md` - Agent modification and improvement specialist
   - `agent-validator.md` - Agent validation and quality checking
   - `agent-installer.md` - Installation and deployment management

### Usage

**Creating New Agents:**
In Claude Code, simply say either:
```
I want to create an agent for [specific purpose]
```
or
```
I want to create a subagent for [specific purpose]
```

The agent-builder will automatically activate and guide you through the 5-phase creation process. It accepts freeform input - feel free to use voice dictation, unstructured thoughts, or rough ideas.

**Editing Existing Agents:**
To modify existing agents, say:
```
I want to edit the [agent-name] agent
```
or
```
Help me improve the [agent-name] subagent
```

The agent-editor will analyze the current agent and guide you through safe modifications with automatic backups.

**Example trigger phrases:**
- "I want to create an agent for API documentation"
- "I want to create a subagent for code reviews"
- "Help me edit the api-docs agent to handle GraphQL"
- "I need to improve the security-analyzer subagent"

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
Structured format with YAML frontmatter and 8-section layout:
```yaml
---
name: agent-name
description: Clear description for automatic invocation
tools: Read, Write, Edit, Bash
---

## Role
What the agent is

## Task
What it does

## Context
When/why it's used

## Audience
Who uses it

## Key Information/Constraints
Important limitations/requirements

## Tone/Style
How it communicates

## Format
Output structure expectations

## Goal/Objective
Success criteria
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
- **agent-editor**: Specialized agent modification and improvement specialist
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

## Agent Builder Logging

All Agent Builder agents automatically log their terminal output and task progress to help improve the system. This provides valuable feedback for identifying issues and enhancing agent performance.

### How It Works

- **Automatic**: Logging is enabled by default for all Agent Builder agents
- **Daily Files**: Each day creates a new log file: `YYYY-MM-DD-agent-builder-log-{agent-name}.txt`  
- **Location**: Log files are created in the root directory where the agent is triggered
- **Multi-Terminal**: Multiple terminals append to the same daily log file
- **Content**: Captures task completions, terminal output, and error messages

### Log File Examples

```
2025-01-15-agent-builder-log-agent-builder.txt
2025-01-15-agent-builder-log-agent-validator.txt
2025-01-15-agent-builder-log-agent-editor.txt
```

### Disabling Logging

If you don't want logging enabled, you can disable it by editing any agent file:

1. Open the agent file: `.claude/agents/{agent-name}.md`
2. Find the line: `**AGENT_LOGGING: true**`
3. Change it to: `**AGENT_LOGGING: false**`

**Note**: Each log file automatically includes instructions on how to disable logging at the top.

### Why Logging Helps

- **Issue Detection**: Identify when agents encounter problems or unexpected behaviors
- **Performance Improvement**: Understand real-world usage patterns
- **Quality Enhancement**: Help refine agent instructions and capabilities
- **User Feedback**: Provide concrete examples for improving the Agent Builder system

### Privacy

- Log files remain on your local machine
- No data is automatically transmitted anywhere
- You control what logs to keep or delete
- Logs contain only terminal output and task progress

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