# Foreman

Foreman turns your main model into a lead engineer. The `orchestrate` skill
teaches it to plan a task, delegate well-scoped work to cheaper subagents,
verify their results by running tests, and deliver a summary with usage
instructions. It stays out of the way for small edits and quick questions.

## What's included

- **`orchestrate` skill**: the workflow and delegation rules for the lead model.
- **`implementer` agent** (Sonnet): writes code within a defined scope.
- **`searcher` agent** (Sonnet): read-only codebase exploration.
- **`reviewer` agent** (Sonnet): independent review; runs tests, never edits.

## Where it works

The skill loads in Claude Code, Cowork, and claude.ai chat. The subagents load
in Claude Code and Cowork only; chat ignores plugin agents, so there the skill
gives planning guidance without delegation.

## What it runs and sends

Foreman contains only Markdown instructions. It has no hooks, no MCP servers,
no scripts, and no network calls of its own, and it sends no data beyond
your normal Claude session. The
subagents use the tools Claude Code already gives them (read, edit, search,
and shell commands such as running your test suite), under your normal
permission settings.

## Install (Claude Code)

```
/plugin marketplace add klee1611/foreman
/plugin install foreman@foreman
```

See the [repository README](https://github.com/klee1611/foreman) for Codex
installation and customization.

## License

MIT
