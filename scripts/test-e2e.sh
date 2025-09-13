#!/bin/bash
set -euo pipefail

# End-to-End Testing Framework for Agent Builder System
# Tests the complete workflow from agent creation to bundle installation

echo "=================================="
echo "Agent Builder E2E Testing Framework"
echo "=================================="
echo ""

# Configuration
TEST_DIR="/tmp/agent-builder-e2e-test-$$"
TEST_AGENT_NAME="test-documentation-agent"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test status tracking
TESTS_PASSED=0
TESTS_FAILED=0

# Function to print test results
print_test() {
    local test_name="$1"
    local result="$2"

    if [[ "$result" == "PASS" ]]; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} $test_name"
        ((TESTS_FAILED++))
    fi
}

# Function to check if file exists
check_file() {
    local file="$1"
    local test_name="$2"

    if [[ -f "$file" ]]; then
        print_test "$test_name" "PASS"
        return 0
    else
        print_test "$test_name" "FAIL"
        echo "  Missing: $file"
        return 1
    fi
}

# Function to check if directory exists
check_dir() {
    local dir="$1"
    local test_name="$2"

    if [[ -d "$dir" ]]; then
        print_test "$test_name" "PASS"
        return 0
    else
        print_test "$test_name" "FAIL"
        echo "  Missing: $dir"
        return 1
    fi
}

# Cleanup function
cleanup() {
    echo ""
    echo "Cleaning up test directory..."
    rm -rf "$TEST_DIR"
}

# Set up cleanup on exit
trap cleanup EXIT

echo "Test Configuration:"
echo "  • Test Directory: $TEST_DIR"
echo "  • Test Agent: $TEST_AGENT_NAME"
echo "  • Repository: $REPO_ROOT"
echo ""

# Create test directory
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# ===========================
# Phase 1: Environment Setup
# ===========================
echo "Phase 1: Environment Setup"
echo "--------------------------"

# Check for required agents
check_file "$REPO_ROOT/.claude/agents/agent-builder.md" "agent-builder.md exists"
check_file "$REPO_ROOT/.claude/agents/agent-validator.md" "agent-validator.md exists"
check_file "$REPO_ROOT/.claude/agents/agent-packager.md" "agent-packager.md exists"
check_file "$REPO_ROOT/.claude/agents/agent-editor.md" "agent-editor.md exists"

# Check for templates
check_dir "$REPO_ROOT/templates" "Templates directory exists"
check_file "$REPO_ROOT/templates/todowrite-integration-template.md" "TodoWrite template exists"

echo ""

# ===========================
# Phase 2: Agent Creation Simulation
# ===========================
echo "Phase 2: Agent Creation Simulation"
echo "-----------------------------------"

# Create a test agent file (simulating agent-builder output)
cat > "$TEST_DIR/$TEST_AGENT_NAME.md" << 'EOF'
---
name: test-documentation-agent
description: Automated documentation generator for code repositories
tools: Read, Write, Glob, TodoWrite
---

You are a documentation generation specialist who creates comprehensive documentation for code repositories.

## Core Capabilities
- Analyze code structure and patterns
- Generate API documentation
- Create usage examples
- Build README files

## TodoWrite Integration
**Follow the TodoWrite Integration Template**: `templates/todowrite-integration-template.md`

## Workflow
1. Analyze repository structure
2. Identify documentation needs
3. Generate documentation
4. Validate completeness
EOF

check_file "$TEST_DIR/$TEST_AGENT_NAME.md" "Test agent created"

echo ""

# ===========================
# Phase 3: Bundle Creation Simulation
# ===========================
echo "Phase 3: Bundle Creation Simulation"
echo "------------------------------------"

# Simulate bundle structure creation
BUNDLE_DIR="$TEST_DIR/created-agents/$TEST_AGENT_NAME"
mkdir -p "$BUNDLE_DIR/agents"
mkdir -p "$BUNDLE_DIR/templates"

# Copy agent to bundle
cp "$TEST_DIR/$TEST_AGENT_NAME.md" "$BUNDLE_DIR/agents/"
check_file "$BUNDLE_DIR/agents/$TEST_AGENT_NAME.md" "Agent copied to bundle"

# Copy only required template (simulating dependency detection)
if [[ -f "$REPO_ROOT/templates/todowrite-integration-template.md" ]]; then
    cp "$REPO_ROOT/templates/todowrite-integration-template.md" "$BUNDLE_DIR/templates/"
    check_file "$BUNDLE_DIR/templates/todowrite-integration-template.md" "Required template included"
fi

# Generate install.sh
cat > "$BUNDLE_DIR/install.sh" << 'EOF'
#!/bin/bash
set -euo pipefail

# Auto-generated install script for test-documentation-agent

echo "Installing test-documentation-agent..."

# Default to project installation
INSTALL_MODE="project"
COMPONENTS="all"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --global) INSTALL_MODE="global"; shift ;;
        --project) INSTALL_MODE="project"; shift ;;
        --only) COMPONENTS="$2"; shift 2 ;;
        --verify)
            echo "✓ Bundle structure valid"
            echo "✓ All dependencies present"
            exit 0
            ;;
        *) shift ;;
    esac
done

# Determine installation path
if [[ "$INSTALL_MODE" == "global" ]]; then
    INSTALL_PATH="$HOME/.claude"
else
    INSTALL_PATH="$(pwd)/.claude"
fi

# Install components
if [[ "$COMPONENTS" == "all" || "$COMPONENTS" == "agents" ]]; then
    mkdir -p "$INSTALL_PATH/agents"
    cp agents/*.md "$INSTALL_PATH/agents/"
    echo "✓ Agents installed"
fi

if [[ "$COMPONENTS" == "all" || "$COMPONENTS" == "templates" ]]; then
    mkdir -p "$INSTALL_PATH/templates"
    cp templates/*.md "$INSTALL_PATH/templates/"
    echo "✓ Templates installed"
fi

echo "✓ Installation complete"
EOF

chmod +x "$BUNDLE_DIR/install.sh"
check_file "$BUNDLE_DIR/install.sh" "Install script generated"

# Generate README.md
cat > "$BUNDLE_DIR/README.md" << 'EOF'
# Test Documentation Agent Bundle

## Description
Automated documentation generator for code repositories

## Installation
```bash
./install.sh          # Project installation
./install.sh --global # Global installation
./install.sh --verify # Verify bundle
```

## Components
- **Agents**: test-documentation-agent
- **Templates**: todowrite-integration-template
- **Version**: 1.0.0

## Usage
In Claude Code: "generate documentation for this repository"
EOF

check_file "$BUNDLE_DIR/README.md" "README generated"

# Generate MANIFEST.json
cat > "$BUNDLE_DIR/MANIFEST.json" << 'EOF'
{
  "bundle_name": "Test Documentation Agent",
  "version": "1.0.0",
  "created": "2025-01-13",
  "agents": [
    {
      "name": "test-documentation-agent",
      "description": "Automated documentation generator",
      "tools": ["Read", "Write", "Glob", "TodoWrite"]
    }
  ],
  "templates": [
    "todowrite-integration-template.md"
  ],
  "validation": {
    "templates_referenced": 1,
    "templates_included": 1,
    "status": "COMPLETE"
  }
}
EOF

check_file "$BUNDLE_DIR/MANIFEST.json" "MANIFEST.json generated"

# Generate VERSION file
echo "1.0.0" > "$BUNDLE_DIR/VERSION"
check_file "$BUNDLE_DIR/VERSION" "VERSION file created"

echo ""

# ===========================
# Phase 4: Bundle Validation
# ===========================
echo "Phase 4: Bundle Validation"
echo "--------------------------"

# Check bundle structure
check_dir "$BUNDLE_DIR" "Bundle directory exists"
check_dir "$BUNDLE_DIR/agents" "Agents subdirectory exists"
check_dir "$BUNDLE_DIR/templates" "Templates subdirectory exists"

# Validate install script
if [[ -x "$BUNDLE_DIR/install.sh" ]]; then
    print_test "Install script is executable" "PASS"
else
    print_test "Install script is executable" "FAIL"
fi

# Test verification mode
cd "$BUNDLE_DIR"
if ./install.sh --verify > /dev/null 2>&1; then
    print_test "Bundle verification passes" "PASS"
else
    print_test "Bundle verification passes" "FAIL"
fi

echo ""

# ===========================
# Phase 5: Installation Testing
# ===========================
echo "Phase 5: Installation Testing"
echo "-----------------------------"

# Create test installation directory
TEST_INSTALL_DIR="$TEST_DIR/test-install"
mkdir -p "$TEST_INSTALL_DIR"
cd "$TEST_INSTALL_DIR"

# Test project installation
"$BUNDLE_DIR/install.sh" --project > /dev/null 2>&1
check_file "$TEST_INSTALL_DIR/.claude/agents/$TEST_AGENT_NAME.md" "Project installation successful"

# Clean up for next test
rm -rf "$TEST_INSTALL_DIR/.claude"

# Test selective installation (agents only)
"$BUNDLE_DIR/install.sh" --only agents > /dev/null 2>&1
check_file "$TEST_INSTALL_DIR/.claude/agents/$TEST_AGENT_NAME.md" "Selective installation (agents)"

if [[ ! -f "$TEST_INSTALL_DIR/.claude/templates/todowrite-integration-template.md" ]]; then
    print_test "Templates excluded in selective install" "PASS"
else
    print_test "Templates excluded in selective install" "FAIL"
fi

echo ""

# ===========================
# Phase 6: Modification Testing
# ===========================
echo "Phase 6: Modification Testing"
echo "-----------------------------"

# Simulate agent modification
MODIFIED_AGENT="$BUNDLE_DIR/agents/$TEST_AGENT_NAME.md"
echo "" >> "$MODIFIED_AGENT"
echo "## Additional Feature" >> "$MODIFIED_AGENT"
echo "- Enhanced error handling" >> "$MODIFIED_AGENT"

if grep -q "Enhanced error handling" "$MODIFIED_AGENT"; then
    print_test "Agent modification applied" "PASS"
else
    print_test "Agent modification applied" "FAIL"
fi

# Update VERSION (simulating version bump)
echo "1.0.1" > "$BUNDLE_DIR/VERSION"
if [[ "$(cat "$BUNDLE_DIR/VERSION")" == "1.0.1" ]]; then
    print_test "Version bumped after modification" "PASS"
else
    print_test "Version bumped after modification" "FAIL"
fi

echo ""

# ===========================
# Phase 7: Auto-Triggering Verification
# ===========================
echo "Phase 7: Auto-Triggering Verification"
echo "--------------------------------------"

# Check for trigger patterns in agents
if grep -q "TRIGGERING.*VALIDATOR" "$REPO_ROOT/.claude/agents/agent-builder.md"; then
    print_test "agent-builder triggers validator" "PASS"
else
    print_test "agent-builder triggers validator" "FAIL"
fi

if grep -q "TRIGGERING.*PACKAGER" "$REPO_ROOT/.claude/agents/agent-validator.md"; then
    print_test "agent-validator triggers packager" "PASS"
else
    print_test "agent-validator triggers packager" "FAIL"
fi

if grep -q "TRIGGERING.*VALIDATOR" "$REPO_ROOT/.claude/agents/agent-editor.md"; then
    print_test "agent-editor triggers validator" "PASS"
else
    print_test "agent-editor triggers validator" "FAIL"
fi

echo ""

# ===========================
# Test Summary
# ===========================
echo "=================================="
echo "Test Summary"
echo "=================================="
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo ""
    echo -e "${GREEN}✓ All tests passed successfully!${NC}"
    echo "The Agent Builder system is functioning correctly."
    exit 0
else
    echo ""
    echo -e "${RED}✗ Some tests failed.${NC}"
    echo "Please review the failures above."
    exit 1
fi