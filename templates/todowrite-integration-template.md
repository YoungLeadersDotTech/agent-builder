# TodoWrite Integration Template

This template provides the standard TodoWrite integration protocols that should be included in all Agent Builder system agents that handle complex multi-step processes.

## Standard TodoWrite Integration Section

```markdown
## MANDATORY OPERATIONAL PROTOCOLS

### 1. TodoWrite Integration (CRITICAL - NO EXCEPTIONS)

**RULE**: TodoWrite usage is MANDATORY for ALL complex multi-step processes. Cannot proceed without proper todo list management.

**Requirements**:
- **MUST** create comprehensive initial todo list before starting any complex operation
- **MUST** create persistent TODO document using `templates/todo-template.md` for tracking
- **MUST** update todo status after completing each major step or phase
- **MUST** mark exactly ONE task as "in_progress" at any time
- **MUST** add new discovered tasks during process execution
- **CANNOT** advance to next phase without completing current todo item
- **CANNOT** declare process "complete" without all todos marked completed

**Persistent TODO Document**:
- Create in `docs/todos/YYYY-MM-DD-{task-name}-todo.md`
- Use `templates/todo-template.md` for structure
- Update with progress, decisions, and blockers
- Include file:line references for all changes
- Use IST (Irish Standard Time) for timestamps

**Initial Todo Template** (create immediately when user requests complex operation):
```
[Customize this template based on the specific agent's workflow]

Example for Agent Creation:
1. "Complete Phase 1: Discovery and requirements gathering" 
2. "Complete Phase 2: Define capabilities and tools"
3. "Complete Phase 3: Establish personality and communication style"
4. "Complete Phase 4: Determine deployment strategy with user choice"
5. "Complete Phase 5: Generate draft agent and get user approval"
6. "Finalize agent structure and validate syntax"
7. "Install agent to appropriate location"
8. "Perform integration testing and verify functionality"
9. "Update conversation log with complete creation timeline"

Example for Agent Modification:
1. "Complete pre-modification analysis of target agent"
2. "Present structured modification approach options to user"
3. "Implement approved modifications with real-time validation"
4. "Perform post-modification testing and integration verification"
5. "Generate modification documentation and audit trail"
6. "Validate modified agent meets enhanced standards"
7. "Create backup and rollback documentation if needed"

Example for Agent Validation:
1. "Perform initial agent file analysis and parsing"
2. "Execute comprehensive structure validation"
3. "Conduct conflict detection across agent ecosystem"
4. "Assess quality standards compliance"
5. "Generate validation report with structured findings"
6. "Present resolution options for any issues found"
7. "Document validation results and recommendations"

Example for Agent Installation:
1. "Validate agent file structure and syntax"
2. "Perform pre-installation compatibility checks" 
3. "Present installation strategy choices to user"
4. "Execute chosen installation approach"
5. "Perform post-installation verification"
6. "Execute integration testing protocols"
7. "Generate installation report and documentation"
8. "Confirm installation success with user validation"
```
```

## Usage Instructions

### When to Use TodoWrite:
- **ALWAYS** for complex multi-step operations (3+ steps)
- **ALWAYS** for processes with user decision points
- **ALWAYS** for operations requiring validation checkpoints
- **ALWAYS** for processes that could fail and need recovery

### When NOT to Use TodoWrite:
- Simple single-step operations
- Pure informational responses
- Basic file reads or simple searches

### Implementation Requirements:

1. **Immediate Todo Creation**: Create todo list as FIRST action when starting complex process
2. **Real-time Updates**: Update status immediately after completing each task
3. **Single Active Task**: Only ONE task should be "in_progress" at any time
4. **Progressive Completion**: Mark tasks complete immediately upon finishing
5. **Dynamic Task Addition**: Add new tasks discovered during execution

### Todo Status Management:

**Task States**:
- `pending`: Task not yet started
- `in_progress`: Currently working on (limit to ONE task at a time)
- `completed`: Task finished successfully

**Task Description Format**:
- `content`: Imperative form ("Complete Phase 1", "Validate syntax")
- `activeForm`: Present continuous form ("Completing Phase 1", "Validating syntax")

### Integration with Persistent TODO Documents:

**Two-Layer TODO System**:
1. **TodoWrite Tool**: Claude's built-in task tracking (ephemeral, session-based)
2. **TODO Documents**: Persistent markdown files for comprehensive tracking

**How They Work Together**:
- TodoWrite tracks immediate tasks during the session
- TODO Documents preserve context across sessions
- Both should be updated in parallel
- TODO Documents capture more detail (decisions, blockers, file:line refs)

**When Session Ends/Restarts**:
1. Check `docs/todos/` for existing TODO documents
2. Resume from documented progress
3. Recreate TodoWrite list from pending tasks in TODO document
4. Continue updating both systems

### Integration with Agent Builder Logging:

TodoWrite should integrate seamlessly with the Agent Builder Logging system:

```markdown
After completing each TodoWrite task, append log entry:
```
================================================================================
[$(date)] Agent: {agent-name} | Task: {task-description} | Status: COMPLETED
================================================================================
{relevant task output, terminal results, or error messages}
================================================================================
```
```

## Error Handling with TodoWrite:

When tasks fail or encounter errors:

1. **Keep task as "in_progress"** (don't mark as completed)
2. **Add new task** for error resolution if needed
3. **Document error** in the task description or add error handling task
4. **Present recovery options** to user using structured choice format

Example error handling:
```
Original task: "Complete Phase 2: Define capabilities and tools" (in_progress)
Error encountered: Missing tool validation
New task added: "Resolve tool validation errors and retry Phase 2" (pending)
```

## Quality Standards:

### Todo List Quality Requirements:
- **Specific**: Tasks should be clear and actionable
- **Comprehensive**: Cover all major steps in the process
- **Sequential**: Ordered logically with dependencies considered
- **Measurable**: Success criteria should be clear
- **User-Oriented**: Written from user's perspective of progress

### Best Practices:
- Start with high-level phases, add detailed tasks as needed
- Use consistent task naming patterns within the agent
- Include validation and verification steps
- Plan for potential error scenarios
- Always include final confirmation/validation tasks

## Agent-Specific Customization:

Each agent should customize the TodoWrite integration based on its specific workflow:

- **agent-builder**: Focus on creation phases and user choice points
- **agent-editor**: Emphasize modification steps and validation checkpoints  
- **agent-validator**: Highlight validation phases and issue resolution
- **agent-installer**: Structure around installation steps and verification

The template should be adapted to match each agent's specific operational patterns while maintaining the core TodoWrite integration requirements.