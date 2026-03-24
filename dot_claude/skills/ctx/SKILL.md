---
name: ctx
description: Use when the user asks for conversation context, wants to understand where they left off, or is context-switching back into a task. Triggers on "/ctx", "where were we", "what were we doing", "catch me up".
---

# Conversation Context

Produce a structured summary of the current conversation so the user can quickly re-orient.

## Output Structure

### Goal
One sentence: what is the user trying to accomplish in this conversation.

### Key Decisions
Bullet list of decisions made, trade-offs chosen, or approaches agreed on. Skip if none.

### Progress
What has been done so far. Reference specific files changed, commands run, or artifacts produced.

### Current State
Where things stand right now. Include:
- Last action taken
- Whether it succeeded or failed
- Any blockers or open questions

### Remaining Work
What is left to do. If a plan or task list exists, summarize outstanding items. If nothing remains, say so.

## Rules

- Be terse. Each section should be 1-3 bullet points max.
- Reference file paths and line numbers where relevant.
- If a plan exists in the conversation, use it as the source of truth for progress and remaining work.
- If tasks exist, check their status via TaskList.
- Skip sections that have no content (e.g., no decisions were made).
- Do not editorialize or suggest next steps unless the user asks.
