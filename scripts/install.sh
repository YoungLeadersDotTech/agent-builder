#!/bin/bash
set -euo pipefail

# Agent Builder Installation Script
# Installs agent builder system to Claude Code projects

echo "Agent Builder Installation"
echo "========================="

# Check if Claude Code is available
if ! command -v claude &> /dev/null; then
    echo "⚠️  Claude Code CLI not found. This toolkit works best with Claude Code."
    echo "   You can still use the portable agents on other platforms."
fi

# Determine installation location
INSTALL_LOCATION=""
GLOBAL_FLAG=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            GLOBAL_FLAG="--global"
            INSTALL_LOCATION="$HOME/.claude/agents"
            echo "📁 Installing globally to $INSTALL_LOCATION"
            shift
            ;;
        --project)
            INSTALL_LOCATION="$(pwd)/.claude/agents"
            echo "📁 Installing to current project: $INSTALL_LOCATION"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--global|--project]"
            exit 1
            ;;
    esac
done

# Default to project installation if no flag specified
if [[ -z "$INSTALL_LOCATION" ]]; then
    INSTALL_LOCATION="$(pwd)/.claude/agents"
    echo "📁 Installing to current project: $INSTALL_LOCATION"
fi

# Create installation directory
mkdir -p "$INSTALL_LOCATION"

# Copy agent files
echo "📦 Installing agent builder system..."
cp -r .claude/agents/* "$INSTALL_LOCATION/"

# Copy templates if they don't exist
TEMPLATE_LOCATION="$(dirname "$INSTALL_LOCATION")/templates"
if [[ ! -d "$TEMPLATE_LOCATION" ]]; then
    echo "📋 Installing templates..."
    mkdir -p "$TEMPLATE_LOCATION"
    cp -r templates/* "$TEMPLATE_LOCATION/"
else
    echo "📋 Templates directory exists, skipping..."
fi

# Verify installation
echo "✅ Verifying installation..."
if [[ -f "$INSTALL_LOCATION/agent-builder.md" ]]; then
    echo "✓ agent-builder.md installed"
else
    echo "❌ agent-builder.md not found"
    exit 1
fi

if [[ -f "$INSTALL_LOCATION/agent-validator.md" ]]; then
    echo "✓ agent-validator.md installed"
else
    echo "❌ agent-validator.md not found"
    exit 1
fi

if [[ -f "$INSTALL_LOCATION/agent-installer.md" ]]; then
    echo "✓ agent-installer.md installed"
else
    echo "❌ agent-installer.md not found"
    exit 1
fi

echo ""
echo "🎉 Agent Builder installed successfully!"
echo ""
echo "Usage:"
echo "  In Claude Code, say: 'I want to create an agent for [purpose]'"
echo "  The agent-builder will automatically activate and guide you."
echo ""
echo "Available agents:"
echo "  • agent-builder: Interactive agent creation"
echo "  • agent-validator: Validate agent structure and quality"
echo "  • agent-installer: Install and deploy agents"
echo ""
echo "Templates available in: $(dirname "$INSTALL_LOCATION")/templates/"
echo ""

if [[ -n "$GLOBAL_FLAG" ]]; then
    echo "ℹ️  Global installation complete. These agents will be available in all Claude Code projects."
else
    echo "ℹ️  Project installation complete. These agents are available in this project only."
    echo "   Use --global flag to install for all projects."
fi