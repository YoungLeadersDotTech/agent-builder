#!/bin/bash

# Agent Builder - Simplified Installation Script
# Installs agents and templates directly from source files
# Single source of truth: .claude/agents/ and templates/

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default installation mode and flags
INSTALL_MODE=""
CHECK_VERSIONS=false
FORCE_INSTALL=false

# Help function
show_help() {
    echo "Agent Builder Installation Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Installation Options:"
    echo "  --global         Install agents globally for system-wide access"
    echo "  --project        Install agents in current project's .claude/agents/"
    echo ""
    echo "Version Control Options:"
    echo "  --check-versions Show version comparison without installing"
    echo "  --force          Force installation, overriding version warnings"
    echo ""
    echo "Other Options:"
    echo "  --help, -h       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --global                    # Install globally (with version check)"
    echo "  $0 --project --force           # Force project installation"
    echo "  $0 --check-versions --global   # Check global versions without installing"
    echo ""
    echo "If no installation option is specified, you'll be prompted to choose."
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            INSTALL_MODE="global"
            shift
            ;;
        --project)
            INSTALL_MODE="project"
            shift
            ;;
        --check-versions)
            CHECK_VERSIONS=true
            shift
            ;;
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Function to prompt for installation mode if not specified
prompt_install_mode() {
    if [[ -z "$INSTALL_MODE" ]]; then
        local mode_purpose="installation"
        if [[ "$CHECK_VERSIONS" == true ]]; then
            mode_purpose="version check"
        fi

        echo -e "${BLUE}Agent Builder - Choose Target for $mode_purpose${NC}"
        echo ""
        echo "Choose target mode:"
        echo "1) Global (system-wide Claude Code directory)"
        echo "2) Project (current project's .claude directory)"
        echo ""
        read -p "Enter choice (1 or 2): " choice

        case $choice in
            1)
                INSTALL_MODE="global"
                ;;
            2)
                INSTALL_MODE="project"
                ;;
            *)
                echo -e "${RED}Invalid choice. Please run the script again.${NC}"
                exit 1
                ;;
        esac
    fi
}

# Function to get target directory based on installation mode
get_target_directory() {
    if [[ "$INSTALL_MODE" == "global" ]]; then
        # Global installation - use Claude Code's global directory
        echo "$HOME/.claude"
    else
        # Project installation - use current directory's .claude
        echo "$(pwd)/.claude"
    fi
}

# Function to get file modification time (cross-platform)
get_file_mtime() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo "0"
        return
    fi

    # Use stat command (works on both Linux and macOS)
    if stat -c %Y "$file" 2>/dev/null; then
        # Linux version
        return
    elif stat -f %m "$file" 2>/dev/null; then
        # macOS version
        return
    else
        # Fallback: use ls and rough estimation
        echo "1"
    fi
}

# Function to compare file versions
compare_file_versions() {
    local source_file="$1"
    local target_file="$2"

    local source_time=$(get_file_mtime "$source_file")
    local target_time=$(get_file_mtime "$target_file")

    if [[ ! -f "$target_file" ]]; then
        echo "new"
    elif [[ "$source_time" -gt "$target_time" ]]; then
        echo "newer"
    elif [[ "$source_time" -lt "$target_time" ]]; then
        echo "older"
    else
        echo "same"
    fi
}

# Function to format file timestamp for display
format_timestamp() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo "not found"
        return
    fi

    # Use ls -l for human-readable timestamp
    ls -l "$file" | awk '{print $6, $7, $8}'
}

# Function to check versions of all files
check_all_versions() {
    local source_dir="$1"
    local target_dir="$2"

    echo -e "${BLUE}Version Comparison Report${NC}"
    echo -e "${YELLOW}Source: $source_dir${NC}"
    echo -e "${YELLOW}Target: $target_dir${NC}"
    echo ""

    local has_conflicts=false
    local update_count=0
    local same_count=0
    local new_count=0

    # Check agents
    echo -e "${BLUE}Agents (.claude/agents/*.md):${NC}"
    local agents_dir="$source_dir/.claude/agents"
    local target_agents_dir="$target_dir/agents"

    if [[ -d "$agents_dir" ]]; then
        for source_file in "$agents_dir"/*.md; do
            if [[ -f "$source_file" ]]; then
                local filename=$(basename "$source_file")
                local target_file="$target_agents_dir/$filename"
                local status=$(compare_file_versions "$source_file" "$target_file")

                case "$status" in
                    "new")
                        echo -e "  ${GREEN}+ $filename${NC} (new file)"
                        new_count=$((new_count + 1))
                        ;;
                    "newer")
                        echo -e "  ${YELLOW}↑ $filename${NC} (source newer - will update)"
                        echo -e "    Source: $(format_timestamp "$source_file")"
                        echo -e "    Target: $(format_timestamp "$target_file")"
                        update_count=$((update_count + 1))
                        ;;
                    "older")
                        echo -e "  ${RED}⚠ $filename${NC} (target newer - will overwrite!)"
                        echo -e "    Source: $(format_timestamp "$source_file")"
                        echo -e "    Target: $(format_timestamp "$target_file")"
                        has_conflicts=true
                        update_count=$((update_count + 1))
                        ;;
                    "same")
                        echo -e "  ${GREEN}= $filename${NC} (same version)"
                        same_count=$((same_count + 1))
                        ;;
                esac
            fi
        done
    fi

    echo ""

    # Check templates
    echo -e "${BLUE}Templates (templates/*.md):${NC}"
    local templates_dir="$source_dir/templates"
    local target_templates_dir="$target_dir/templates"

    if [[ -d "$templates_dir" ]]; then
        for source_file in "$templates_dir"/*.md; do
            if [[ -f "$source_file" ]]; then
                local filename=$(basename "$source_file")
                local target_file="$target_templates_dir/$filename"
                local status=$(compare_file_versions "$source_file" "$target_file")

                case "$status" in
                    "new")
                        echo -e "  ${GREEN}+ $filename${NC} (new file)"
                        new_count=$((new_count + 1))
                        ;;
                    "newer")
                        echo -e "  ${YELLOW}↑ $filename${NC} (source newer - will update)"
                        echo -e "    Source: $(format_timestamp "$source_file")"
                        echo -e "    Target: $(format_timestamp "$target_file")"
                        update_count=$((update_count + 1))
                        ;;
                    "older")
                        echo -e "  ${RED}⚠ $filename${NC} (target newer - will overwrite!)"
                        echo -e "    Source: $(format_timestamp "$source_file")"
                        echo -e "    Target: $(format_timestamp "$target_file")"
                        has_conflicts=true
                        update_count=$((update_count + 1))
                        ;;
                    "same")
                        echo -e "  ${GREEN}= $filename${NC} (same version)"
                        same_count=$((same_count + 1))
                        ;;
                esac
            fi
        done
    fi

    echo ""
    echo -e "${BLUE}Summary:${NC}"
    echo -e "  New files: $new_count"
    echo -e "  Files to update: $update_count"
    echo -e "  Files unchanged: $same_count"

    if [[ "$has_conflicts" == true ]]; then
        echo ""
        echo -e "${RED}⚠ WARNING: Some installed files are newer than source files!${NC}"
        echo -e "${RED}Installing will overwrite your newer installed versions.${NC}"
        echo -e "${YELLOW}Use --force to override this warning, or update your source files first.${NC}"
        return 1
    fi

    return 0
}

# Function to create directory if it doesn't exist
create_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        echo -e "${BLUE}Creating directory: $dir${NC}"
        mkdir -p "$dir"
    fi
}

# Function to copy agents with version checking
copy_agents() {
    local source_dir="$1/.claude/agents"
    local target_dir="$2/agents"

    echo -e "${BLUE}Installing agents...${NC}"
    create_directory "$target_dir"

    # Count agents for progress feedback
    local agent_count=$(find "$source_dir" -name "*.md" -type f | wc -l)
    echo -e "${YELLOW}Found $agent_count agents to install${NC}"

    local updated_count=0
    local skipped_count=0

    # Copy each agent file with version awareness
    for agent_file in "$source_dir"/*.md; do
        if [[ -f "$agent_file" ]]; then
            local agent_name=$(basename "$agent_file")
            local target_file="$target_dir/$agent_name"
            local status=$(compare_file_versions "$agent_file" "$target_file")

            case "$status" in
                "new")
                    echo -e "  ${GREEN}+ Installing new agent: $agent_name${NC}"
                    cp "$agent_file" "$target_dir/"
                    updated_count=$((updated_count + 1))
                    ;;
                "newer")
                    echo -e "  ${YELLOW}↑ Updating agent: $agent_name${NC}"
                    cp "$agent_file" "$target_dir/"
                    updated_count=$((updated_count + 1))
                    ;;
                "older")
                    if [[ "$FORCE_INSTALL" == true ]]; then
                        echo -e "  ${RED}⚠ Force overwriting newer agent: $agent_name${NC}"
                        cp "$agent_file" "$target_dir/"
                        updated_count=$((updated_count + 1))
                    else
                        echo -e "  ${RED}⚠ Skipping older agent: $agent_name (target is newer)${NC}"
                        skipped_count=$((skipped_count + 1))
                    fi
                    ;;
                "same")
                    echo -e "  ${GREEN}= Agent up to date: $agent_name${NC}"
                    skipped_count=$((skipped_count + 1))
                    ;;
            esac
        fi
    done

    echo -e "${GREEN}Agents processing complete! Updated: $updated_count, Skipped: $skipped_count${NC}"
}

# Function to copy templates with version checking
copy_templates() {
    local source_dir="$1/templates"
    local target_dir="$2/templates"

    echo -e "${BLUE}Installing templates...${NC}"
    create_directory "$target_dir"

    # Count templates for progress feedback
    local template_count=$(find "$source_dir" -name "*.md" -type f | wc -l)
    echo -e "${YELLOW}Found $template_count templates to install${NC}"

    local updated_count=0
    local skipped_count=0

    # Copy each template file with version awareness
    for template_file in "$source_dir"/*.md; do
        if [[ -f "$template_file" ]]; then
            local template_name=$(basename "$template_file")
            local target_file="$target_dir/$template_name"
            local status=$(compare_file_versions "$template_file" "$target_file")

            case "$status" in
                "new")
                    echo -e "  ${GREEN}+ Installing new template: $template_name${NC}"
                    cp "$template_file" "$target_dir/"
                    updated_count=$((updated_count + 1))
                    ;;
                "newer")
                    echo -e "  ${YELLOW}↑ Updating template: $template_name${NC}"
                    cp "$template_file" "$target_dir/"
                    updated_count=$((updated_count + 1))
                    ;;
                "older")
                    if [[ "$FORCE_INSTALL" == true ]]; then
                        echo -e "  ${RED}⚠ Force overwriting newer template: $template_name${NC}"
                        cp "$template_file" "$target_dir/"
                        updated_count=$((updated_count + 1))
                    else
                        echo -e "  ${RED}⚠ Skipping older template: $template_name (target is newer)${NC}"
                        skipped_count=$((skipped_count + 1))
                    fi
                    ;;
                "same")
                    echo -e "  ${GREEN}= Template up to date: $template_name${NC}"
                    skipped_count=$((skipped_count + 1))
                    ;;
            esac
        fi
    done

    echo -e "${GREEN}Templates processing complete! Updated: $updated_count, Skipped: $skipped_count${NC}"
}

# Function to create TODO documentation directories
create_todo_structure() {
    local target_dir="$1"

    echo -e "${BLUE}Creating TODO documentation structure...${NC}"

    # Create docs/todos directory structure
    local docs_dir="$target_dir/docs"
    local todos_dir="$docs_dir/todos"

    create_directory "$docs_dir"
    create_directory "$todos_dir"

    # Create basic README for docs structure
    cat > "$docs_dir/README.md" << 'EOF'
# Agent Builder Documentation

This directory contains documentation and TODO tracking for the Agent Builder system.

## Structure

- `todos/` - TODO documents and workflow tracking
- Additional documentation files as needed

## Usage

The Agent Builder system automatically creates TODO documents in the `todos/` directory
to track complex operations and multi-phase workflows.
EOF

    echo -e "${GREEN}TODO documentation structure created!${NC}"
}

# Function to validate installation
validate_installation() {
    local target_dir="$1"
    local errors=0

    echo -e "${BLUE}Validating installation...${NC}"

    # Check if agents directory exists and has files
    if [[ ! -d "$target_dir/agents" ]] || [[ -z "$(ls -A "$target_dir/agents" 2>/dev/null)" ]]; then
        echo -e "${RED}✗ Agents directory missing or empty${NC}"
        errors=$((errors + 1))
    else
        local agent_count=$(ls "$target_dir/agents"/*.md 2>/dev/null | wc -l)
        echo -e "${GREEN}✓ Agents directory: $agent_count agents installed${NC}"
    fi

    # Check if templates directory exists and has files
    if [[ ! -d "$target_dir/templates" ]] || [[ -z "$(ls -A "$target_dir/templates" 2>/dev/null)" ]]; then
        echo -e "${RED}✗ Templates directory missing or empty${NC}"
        errors=$((errors + 1))
    else
        local template_count=$(ls "$target_dir/templates"/*.md 2>/dev/null | wc -l)
        echo -e "${GREEN}✓ Templates directory: $template_count templates installed${NC}"
    fi

    # Check if docs/todos structure exists
    if [[ ! -d "$target_dir/docs/todos" ]]; then
        echo -e "${RED}✗ TODO documentation structure missing${NC}"
        errors=$((errors + 1))
    else
        echo -e "${GREEN}✓ TODO documentation structure created${NC}"
    fi

    return $errors
}

# Main installation function
main() {
    # Get the script's directory (source directory)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Verify we're in the Agent Builder directory
    if [[ ! -d "$SCRIPT_DIR/.claude/agents" ]]; then
        echo -e "${RED}Error: This script must be run from the Agent Builder directory${NC}"
        echo -e "${RED}Could not find .claude/agents/ in: $SCRIPT_DIR${NC}"
        exit 1
    fi

    # Handle check-versions mode
    if [[ "$CHECK_VERSIONS" == true ]]; then
        # Prompt for installation mode if not specified (needed for target directory)
        prompt_install_mode
        TARGET_DIR=$(get_target_directory)

        echo -e "${BLUE}Agent Builder Version Check${NC}"
        echo -e "${YELLOW}Installation mode: $INSTALL_MODE${NC}"
        echo ""

        check_all_versions "$SCRIPT_DIR" "$TARGET_DIR"

        if [[ $? -eq 0 ]]; then
            echo ""
            echo -e "${GREEN}Version check completed. No conflicts detected.${NC}"
            echo -e "${YELLOW}Run without --check-versions to proceed with installation.${NC}"
        else
            echo ""
            echo -e "${RED}Version conflicts detected. Use --force to override warnings.${NC}"
        fi
        return
    fi

    # Prompt for installation mode if not specified
    prompt_install_mode

    # Get target directory
    TARGET_DIR=$(get_target_directory)

    echo -e "${BLUE}Agent Builder Installation${NC}"
    echo -e "${YELLOW}Installation mode: $INSTALL_MODE${NC}"
    echo -e "${YELLOW}Target directory: $TARGET_DIR${NC}"

    if [[ "$FORCE_INSTALL" == true ]]; then
        echo -e "${YELLOW}Force mode: ON (will override version warnings)${NC}"
    fi
    echo ""

    # Check for version conflicts before installation (unless forced)
    if [[ "$FORCE_INSTALL" != true ]]; then
        echo -e "${BLUE}Checking for version conflicts...${NC}"
        if ! check_all_versions "$SCRIPT_DIR" "$TARGET_DIR"; then
            echo ""
            echo -e "${RED}Installation cancelled due to version conflicts.${NC}"
            echo -e "${YELLOW}Options:${NC}"
            echo -e "  1. Use --force to override warnings and install anyway"
            echo -e "  2. Use --check-versions to see detailed comparison"
            echo -e "  3. Update your source files to match or exceed installed versions"
            exit 1
        fi
        echo ""
    fi

    # Create target directory if it doesn't exist
    create_directory "$TARGET_DIR"

    # Copy agents from source
    copy_agents "$SCRIPT_DIR" "$TARGET_DIR"
    echo ""

    # Copy templates from source
    copy_templates "$SCRIPT_DIR" "$TARGET_DIR"
    echo ""

    # Create TODO documentation structure
    create_todo_structure "$TARGET_DIR"
    echo ""

    # Validate installation
    if validate_installation "$TARGET_DIR"; then
        echo -e "${GREEN}Installation completed successfully!${NC}"
        echo ""
        echo -e "${BLUE}What's installed:${NC}"
        echo -e "• Agent Builder system agents"
        echo -e "• Agent and template files"
        echo -e "• TODO documentation structure"
        echo ""
        echo -e "${BLUE}Usage:${NC}"
        echo -e "To create a new agent, simply say:"
        echo -e "\"I want to create an agent for [specific purpose]\""
        echo ""
        echo -e "The agent-builder will automatically activate and guide you through"
        echo -e "a structured creation process."
        echo ""
        echo -e "${BLUE}Version Management:${NC}"
        echo -e "• Use --check-versions to compare file versions before installing"
        echo -e "• Use --force to override version warnings"
    else
        echo -e "${RED}Installation completed with errors. Please check the output above.${NC}"
        exit 1
    fi
}

# Run main function
main "$@"