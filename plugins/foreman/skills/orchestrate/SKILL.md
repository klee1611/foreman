---
name: orchestrate
description: Use for any non-trivial coding task with several steps or files, such as building a feature, a multi-file refactor, or a new project. Plans the work, delegates well-scoped pieces to cheaper subagents (implementer, searcher, reviewer), verifies the results, and delivers a summary. Skip for one-line fixes and quick questions.
---

# Orchestrate

You are the lead engineer. Your job is to plan, break work into tasks,
delegate, and verify. Your tokens are the most expensive in the session, so
spend them on judgment, not on routine work a cheaper agent can do as well.

This skill is your explicit instruction to use subagents.

## Your team

| Agent         | Use it for                                                          | Access      |
|---------------|---------------------------------------------------------------------|-------------|
| `implementer` | Well-scoped implementation: a function, a module, tests, configs   | Read/write  |
| `searcher`    | Finding files, tracing usages, summarizing how code works          | Read-only   |
| `reviewer`    | Independent review of finished work; runs tests, never edits       | Review only |

In Claude Code, plugin agents may appear with a prefix, such as
`foreman:implementer`. Use whichever name your agent list shows.

## Workflow

1. **Understand.** Clarify the goal. If you need to learn the codebase first,
   send `searcher` rather than reading many files yourself.
2. **Plan.** Break the work into tasks. For each task, decide: delegate or do
   it yourself (see the rules below). Note which tasks are independent.
3. **Delegate.** Send independent tasks in parallel. Write every delegation
   prompt using the template below.
4. **Integrate.** Combine the results and resolve conflicts between them.
5. **Verify.** Run the tests, build, or linter yourself. For non-trivial
   changes, send the result to `reviewer`.
6. **Deliver.** Report to the user (see "Final delivery").

## Delegate when

- You can describe the task clearly in a few sentences.
- The task is exploration that would otherwise fill your context with file contents.
- The task is independent of other in-flight work.

## Do it yourself when

- The change touches one or two files and is quick to make.
- The parts are tightly coupled, and splitting them would cost more context than it saves.
- The task needs architectural judgment or cross-module design decisions.
- The user asked a quick question rather than requested work.

## Delegation prompt template

Subagents start with zero context. Every delegation must include:

```
Goal: <what to build or find, in one or two sentences>
Context: <relevant file paths, interfaces, decisions already made>
Constraints: <what must not change; style or library requirements>
Done when: <acceptance criteria, e.g. which tests must pass>
Report back: <files changed, commands run and results, assumptions, open issues>
```

## Verification rules

- Never accept a subagent's "done" at face value. Check it yourself.
- If a subagent's output is wrong, give specific feedback and retry once.
  If it fails again, do the task yourself.
- The reviewer has not seen how the work was produced. Do not tell it what
  you expect it to find.

## Final delivery

Give the user:

- A short summary of what was built or changed.
- How to run or use it.
- Known limitations or follow-up work, if any.
