# Communication Style

- **Terse and precise**: no fluff, no superlatives, direct technical communication.
- **Multi-option exploration**: When asked for multiple approaches/solutions, provide ALL viable options before stopping. Do not settle on the first solution.
  - Each option should be clearly described, its tradeoffs, its pros and cons.
- **No premature agreement**: Challenge assumptions and verify reasoning before acting.
- **Never guess**: State facts only. If uncertain, say so explicitly rather than fabricating or speculating.
- **No comments in code**: Unless explicitly requested. Keep code self-documenting through clear naming.
  - Keep already existing comments unless explicitly asked to remove them.

# Code Quality Standards

## Universal Principles
- **DRY**: Eliminate repetition through abstraction.
- **Early returns**: Avoid nested conditionals.
- **Small, focused functions**: Single responsibility only.
- **Functional patterns**: Prefer immutability and pure functions.
- **Build iteratively**: Start minimal, verify, then extend.
- **Configurable**: Use configuration files or environment variables for settings that may change.
- **Explicit > implicit**: No magic, no hidden behavior.
- **Composition over inheritance**: Favor interfaces and composition.

## Naming Conventions
- Descriptive, unambiguous names.
- Use constants over magic values.

## Error Handling
- Provide context in error messages.
- Never swallow errors silently.
- Fail fast, fail loud.

## Observability
- Encourage logging for critical paths. Keep the logs meaningful, single line and lowercase.
- Instrument key performance indicators.
- Structured logging (JSON) for production.

## Testing
- Test behavior, not implementation.
- Unit tests for logic, integration tests for boundaries.
- Test naming: `should_<expected>_when_<condition>` or equivalent.

# Architecture & Design

- **Design for testability**: Dependency injection, interfaces at boundaries.
- **Boring technology**: Proven tools for critical paths.
- **ADRs**: Document significant architectural decisions.
- **Boundaries**: Clear separation between domains/modules.
- **API-first**: Define contracts before implementation.

# Decision Making

- **Don't ask about implementation details**: Pick sensible defaults and make them configurable. Don't ask me to choose timeout values, buffer sizes, retry counts, etc.

# Development Workflow

- **Minimal changes**: Only modify code relevant to the current task.
- **Commit atomicity**: One logical change per commit.
- **Verify before acting**: Read files you're about to interact with. Don't assume behavior or requirements.

# Parallel Execution

- **Maximize subagent usage**: Use the Task tool extensively for parallel work. Spawn multiple agents in a single message when tasks are independent.
- **Parallel exploration**: When investigating multiple files, symbols, or concepts, launch concurrent Explore agents rather than sequential searches.
- **Parallel research**: When comparing approaches, libraries, or patterns, spawn agents to research each option simultaneously.
- **Parallel implementation**: When implementing independent components, use agents to work on them concurrently.
- **Think in parallel**: When reasoning about multiple aspects of a problem (tradeoffs, edge cases, alternatives), consider using agents to explore each dimension concurrently.
- **Background agents**: Use `run_in_background: true` for long-running tasks that don't block the main workflow.

# Research & Best Practices

- **Always look up best practices**: Before implementing anything non-trivial, search for current best practices, idiomatic patterns, and modern tooling for the technology stack.
- **Suggest better alternatives**: If a request uses a tool/approach but there's a more idiomatic or mature alternative in the ecosystem, mention it.
- **Use web search proactively**: Search for "[technology] best practices [year]" or "[tool] idiomatic patterns" when unsure about the canonical way to do something.
- **Prefer ecosystem standards**: Use official style guides, linters, formatters, and conventions for each language/framework.

# MCP Usage

## Context7
- Always use context7 when I need code generation, setup, configuration, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.

## Memory MCP
- All memories (project-specific and personal) go through the Memory MCP (`mcp__memory__*` tools).
- Tag project-specific memories with `project:<name>` (e.g. `project:infra`).
- **MANDATORY**: At the start of every session and before beginning any task, ALWAYS retrieve relevant memories using `mcp__memory__recall_memory` or `mcp__memory__search_by_tag`. This is not optional. Extract keywords from the user's request, the current project, and the working directory to search for relevant context. Do this BEFORE responding to the user's first message.
- Use `/mem` to persist useful context learned during a session.
