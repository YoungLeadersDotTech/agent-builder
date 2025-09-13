# Publishing Guide for Agent Builder Agents

## Overview

This guide explains how to properly develop, test, and publish agents created with the Agent Builder system, avoiding common pitfalls like directory pollution and update confusion.

## Core Principles

1. **Never install agents in their development repository**
2. **Always use --global for testing your own agents**
3. **Edit source files, not installed copies**
4. **Keep development bundles out of git**

## Directory Structure

```
your-agent-project/
├── .claude/agents/           # Source agents (commit these)
├── created-agents/           # Development bundles (gitignored)
├── dist/                     # Distribution bundles (optional, for releases)
├── templates/                # Shared templates (commit these)
└── .gitignore               # Must exclude created-agents/
```

## Development Workflow

### 1. Create Your Agent

```bash
# In Claude Code
"I want to create an agent for [purpose]"
```

This creates:
- Source agent in `.claude/agents/`
- Development bundle in `created-agents/` (gitignored)

### 2. Test Your Agent

```bash
# Install globally for testing
cd created-agents/your-agent
./install.sh --global

# Now test in a DIFFERENT project
cd ~/some-other-project
# Use your agent there
```

**⚠️ WARNING**: Never run `./install.sh --project` in the same repository where you're developing the agent!

### 3. Edit and Iterate

```bash
# Edit the SOURCE file
vim .claude/agents/your-agent.md

# Regenerate bundle
"package my agent into a bundle"

# Reinstall globally
cd created-agents/your-agent
./install.sh --global
```

### 4. Prepare for Publishing

#### Option A: Source-Only Repository (Recommended)

Users create their own bundles:

```bash
# Your .gitignore
created-agents/    # Exclude development bundles
.claude/           # Exclude installed agents

# What to commit
✓ .claude/agents/*.md (source agents)
✓ templates/*.md (templates)
✓ README.md (with instructions)
```

**README instructions for users:**
```markdown
## Installation

1. Use agent-builder to create bundle:
   "create bundle from .claude/agents/my-agent.md"

2. Install the bundle:
   cd created-agents/my-agent
   ./install.sh --global
```

#### Option B: Include Distribution Bundle

Create a clean distribution version:

```bash
# Create dist version
mkdir -p dist/
cp -r created-agents/your-agent dist/

# Commit dist/ but not created-agents/
git add dist/
git commit -m "Add distribution bundle"
```

**README instructions:**
```markdown
## Installation

cd dist/your-agent
./install.sh --global
```

#### Option C: GitHub Releases

Keep repo clean, use releases for bundles:

```bash
# Create release bundle
cd created-agents/your-agent
tar -czf ../../your-agent-v1.0.0.tar.gz .

# Upload to GitHub Releases
# Users download and extract
```

## Publishing Checklist

Before publishing your agent:

- [ ] Source agents in `.claude/agents/` are final
- [ ] Templates in `templates/` are included
- [ ] `.gitignore` excludes `created-agents/`
- [ ] README has clear installation instructions
- [ ] No installed agents in `.claude/` committed
- [ ] Bundle tested with `--global` installation
- [ ] Version number updated if applicable
- [ ] License file included if needed

## Common Mistakes to Avoid

### ❌ Don't: Install in Development Repo
```bash
cd my-agent-project
cd created-agents/my-agent
./install.sh --project  # Creates duplicates!
```

### ✅ Do: Install Globally or in Different Project
```bash
cd created-agents/my-agent
./install.sh --global  # Clean separation
```

### ❌ Don't: Edit Installed Copies
```bash
vim .claude/agents/my-agent.md  # Wrong if installed
```

### ✅ Do: Edit Source, Rebuild, Reinstall
```bash
vim .claude/agents/my-agent.md  # Edit source
# Rebuild bundle with agent-packager
# Reinstall from new bundle
```

### ❌ Don't: Commit Everything
```bash
git add .  # Includes created-agents/, .claude/
```

### ✅ Do: Commit Selectively
```bash
git add .claude/agents/*.md templates/ README.md
git commit -m "Add agent source files"
```

## Update Strategy

### For Agent Developers

1. Edit source in `.claude/agents/`
2. Rebuild bundle with agent-packager
3. Test with global installation
4. Publish new version

### For Agent Users

1. Pull latest from repository
2. Rebuild bundle (if source-only)
3. Or use new dist/ bundle
4. Reinstall with `./install.sh --global`

## Installation Warnings

The smart installer will warn when:
- Installing in a development repository
- Creating duplicate agents
- Potential for confusion

Users can override with `--force` but should use `--global` instead.

## Best Practices

1. **Development**: Use agent-builder repo as a workspace
2. **Testing**: Always test in separate projects
3. **Distribution**: Choose one clear method (A, B, or C)
4. **Documentation**: Make installation crystal clear
5. **Versioning**: Use semantic versioning for releases

## Support

If users are confused about installation:
1. Point them to use `--global`
2. Explain the development vs. distribution separation
3. Share this guide

## Quick Reference

```bash
# Development
edit .claude/agents/my-agent.md
create bundle → created-agents/my-agent/
test with --global

# Distribution
Option A: Share source only
Option B: Include dist/ folder
Option C: GitHub Releases

# Installation (for users)
./install.sh --global     # Recommended
./install.sh --project    # Only in other projects
./install.sh --force      # Override warnings
```