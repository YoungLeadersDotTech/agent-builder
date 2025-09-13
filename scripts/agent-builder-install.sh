#!/bin/bash
set -euo pipefail

# Agent Builder Bundle Installation Script
# Uses the self-contained bundle architecture for installation

echo "Agent Builder Bundle Installation"
echo "=================================="

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Check if bundle exists
BUNDLE_DIR="$REPO_ROOT/created-agents/agent-builder"

if [[ ! -d "$BUNDLE_DIR" ]]; then
    echo "❌ Bundle not found at: $BUNDLE_DIR"
    echo ""
    echo "The agent-builder bundle needs to be created first."
    echo "This should have been done automatically during setup."
    echo ""
    echo "To create the bundle manually:"
    echo "1. Use agent-builder to create the agent-builder agent"
    echo "2. Validate it with agent-validator"
    echo "3. Package it with agent-packager"
    echo ""
    exit 1
fi

# Check if bundle has install script
if [[ ! -f "$BUNDLE_DIR/install.sh" ]]; then
    echo "❌ Bundle install.sh not found at: $BUNDLE_DIR/install.sh"
    echo "The bundle appears to be incomplete."
    exit 1
fi

# Make install script executable
chmod +x "$BUNDLE_DIR/install.sh"

# Forward all arguments to the bundle's install script
echo "📦 Using bundle installation at: $BUNDLE_DIR"
echo ""

cd "$BUNDLE_DIR"
./install.sh "$@"

# Check exit code
if [[ $? -eq 0 ]]; then
    echo ""
    echo "🎉 Agent Builder successfully installed from bundle!"
    echo ""
    echo "Bundle Details:"
    if [[ -f "$BUNDLE_DIR/MANIFEST.json" ]]; then
        echo "  • Version: $(grep -o '"version": "[^"]*"' MANIFEST.json | cut -d'"' -f4)"
        echo "  • Agents: $(grep -c '"name"' MANIFEST.json | head -1) included"
        echo "  • Templates: $(grep -o '"templates": \[.*\]' MANIFEST.json | grep -o '"' | wc -l | awk '{print $1/2}')"
    fi
    echo ""
    echo "The bundle architecture ensures all dependencies are included"
    echo "and properly versioned for consistent installation."
else
    echo "❌ Installation failed. Please check the error messages above."
    exit 1
fi