# Quick Usage Reference

## Creating Agents

```bash
# In Claude Code, simply say:
"I want to create an agent for [purpose]"
```

The agent-builder will guide you through a 5-phase process.

## Installation Commands

### Global Installation (Recommended)
```bash
# From the agent-builder root directory
./install.sh --global
```

### Project Installation
```bash
# Install to current project
./install.sh --project
```

## Agent Commands

### Core Agents
- **Create**: "I want to create an agent for X"
- **Validate**: "validate my agent"
- **Package**: "package my agent into a bundle"
- **Edit**: "edit my agent to add Y"

### Auto-Triggering
Agents automatically trigger each other:
```
agent-builder → agent-validator → agent-packager
                      ↓
                agent-editor → agent-validator
```

## Directory Structure

```
Working Directory:
├── .claude/agents/        # Source agents (edit here)
├── created-agents/        # Dev bundles (gitignored)
└── dist/                  # Distribution (optional)
```

## Key Rules

1. **Never** install in development repository (use --global)
2. **Always** edit source files, not installed copies
3. **Don't** commit `created-agents/` folder
4. **Do** test with --global installation

## Common Workflows

### Development Workflow
```bash
1. Edit: .claude/agents/my-agent.md
2. Package: "package my agent"
3. Install: ./install.sh --global
4. Test: In different project
```

### Distribution Workflow
```bash
1. Finalize agent in .claude/agents/
2. Create bundle with agent-packager (goes to created-agents/)
3. Choose distribution method:
   - Share source (users run agent-packager)
   - Share complete bundle from created-agents/
   - Push to GitHub for others to clone
```

## Troubleshooting

### Installation Warnings
If you see "Installing in development repository":
- Use `--global` instead
- Or use `--force` to override
- See [PUBLISHING.md](../PUBLISHING.md) for details

### Agent Not Found
- Check installation location
- Verify with `ls ~/.claude/agents/`
- Reinstall with --global if needed

### Bundle Issues
- Verify with `./install.sh --verify`
- Check MANIFEST.json for completeness
- Regenerate with agent-packager

## Quick Tips

- Test agents in separate projects
- Use --global for development
- Keep bundles out of git
- Follow PUBLISHING.md for sharing

---

For detailed guides, see:
- [README.md](../README.md) - Complete overview
- [PUBLISHING.md](../PUBLISHING.md) - Publishing workflow
- [INSTALLATION_WORKFLOW.md](INSTALLATION_WORKFLOW.md) - Technical details