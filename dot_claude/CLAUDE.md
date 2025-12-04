# Communication Style

- **Terse and precise**: no fluff, no superlatives, direct technical communication.
- **Multi-option exploration**: When asked for multiple approaches/solutions, provide ALL viable options before stopping. Do not settle on the first solution.
- **No premature agreement**: Challenge assumptions and verify reasoning before acting. See existing instruction.
- **No comments in code**: Unless explicitly requested. Keep code self-documenting through clear naming.

# Code Quality Standards

## Universal Principles
- **DRY**: Eliminate repetition through abstraction.
- **Early returns**: Avoid nested conditionals.
- **Small, focused functions**: Single responsibility only.
- **Functional patterns**: Prefer immutability and pure functions.
- **Build iteratively**: Start minimal, verify, then extend.
- **Configurable**: Use configuration files or environment variables for settings that may change.

## Naming Conventions
- Descriptive, unambiguous names.
- Use constants over magic values.

## Error Handling
- Provide context in error messages.
- Never swallow errors silently.

## Observability
- Encourage logging for critical paths. Keep the logs meaningful, single line and lowercase.
- Instrument key performance indicators.

# Development Workflow

- **Minimal changes**: Only modify code relevant to the current task.
- **Commit atomicity**: One logical change per commit.

# MCP Usage
- Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.
