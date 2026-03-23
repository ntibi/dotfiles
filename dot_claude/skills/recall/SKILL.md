---
name: recall
description: Use before ANY task. This includes implementing features, fixing bugs, debugging, answering questions, making technical decisions, switching modules, AND before asking the user any clarifying question. If you are about to do anything or ask anything, recall first. No exceptions.
---

# Memory Recall

Before proceeding with the current task, recall relevant memories from prior sessions. Before asking the user a question, recall first. The answer is often already in memory from a prior session.

## Steps

1. Identify the key topics: module name, technology, error message, file path, library, concept, or question involved in the current task.
2. Call `recall_memory` with a descriptive query covering those topics.
3. If the task spans multiple modules or technologies, make multiple `recall_memory` calls in parallel.
4. Read the results. If any memories are outdated or wrong, update or delete them.
5. Proceed with the task, informed by what you recalled. Do NOT ask the user something that was already answered in a recalled memory.
6. If you end up asking the user a clarifying question and they answer it, store that answer as a memory if it would be useful in future sessions.
