Store memories via the Memory MCP (mcp__memory__store_memory). Review the conversation for anything worth preserving:

- User preferences and workflow habits
- Project-specific conventions and patterns
- Architectural decisions and their rationale
- Solutions to problems that took effort to find
- Recurring issues and their fixes
- Configuration details and deployment gotchas
- Tools and libraries used (versions, gotchas)

## Tagging convention

- Always include a `project:<name>` tag derived from the working directory (e.g. `project:memory`, `project:infra`).
- Add descriptive topic tags (e.g. `deployment`, `docker`, `debugging`, `rust`, `nomad`).
- Check existing tags with `mcp__memory__search_by_tag` before inventing new ones to avoid fragmentation.

## Rules

- One memory per distinct fact/insight. Don't bundle unrelated things.
- Before storing, search existing memories (`mcp__memory__search_by_tag` with project tag, `mcp__memory__recall_memory` with relevant query) to avoid duplicates.
- If a memory supersedes a previous one, store the new version alongside it. Don't delete old memories unless they're clearly wrong.
- Store liberally — prefer too many memories over missing context in a future session.
