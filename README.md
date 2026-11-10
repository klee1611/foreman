# Foreman

**Your premium model plans and verifies. Cheaper models do the routine work.**

Foreman turns the main agent in Claude Code or Codex into a lead engineer. It
breaks a task into pieces, hands well-scoped work to cheaper subagents, checks
their results, and gives you the finished product with instructions.

```
                ┌───────────────────────────────┐
     you ──────▶│ Lead (Opus / your main model) │  plans · decides · verifies
                └───────────────┬───────────────┘
                 ┌──────────────┼──────────────┐
                 ▼              ▼              ▼
          ┌─────────────┐┌─────────────┐┌─────────────┐
          │ implementer ││  searcher   ││  reviewer   │
          │   writes    ││    reads    ││   checks    │
          └─────────────┘└─────────────┘└─────────────┘
```

## Why

Premium models are excellent at judgment and expensive per token. Most of a
coding session is not judgment: it is reading files, writing boilerplate, and
running tests. Foreman keeps the expensive model on decisions and moves the
bulk work to cheaper ones.

It also fixes a common annoyance: the main agent often does everything itself
and never uses subagents. Foreman gives it explicit rules for when to delegate
and when not to.

## What's inside

| Component     | Claude Code      | Codex            | Role                                      |
|---------------|------------------|------------------|-------------------------------------------|
| `orchestrate` | Skill            | Skill            | Workflow and delegation rules for the lead |
| `implementer` | Sonnet subagent  | `gpt-5.4-mini`   | Writes code within a defined scope        |
| `searcher`    | Sonnet subagent  | `gpt-5.4-mini`   | Read-only codebase exploration            |
| `reviewer`    | Sonnet subagent  | `gpt-5.4-mini`   | Independent review; runs tests, never edits |

`searcher` uses Sonnet rather than Haiku on purpose. A search agent that
silently misses a call site ("no other usages exist") misleads every decision
the lead makes afterwards. Cheap is not worth wrong here.

## Install

### Claude Code

```
/plugin marketplace add klee1611/foreman
/plugin install foreman@foreman
```

Choose **user scope** when prompted so it works in every project. Then run
`/agents` to confirm the three agents are listed.

Or from your shell:

```bash
claude plugin marketplace add klee1611/foreman
claude plugin install foreman@foreman
```

To get new versions later: `claude plugin update foreman@foreman`.

### Codex

```bash
codex plugin marketplace add klee1611/foreman
codex plugin add foreman@foreman
```

Codex plugins ship skills, but custom subagents are separate TOML files.
Install them with:

```bash
git clone https://github.com/klee1611/foreman.git
cd foreman
./scripts/install-codex-agents.sh
```

Make sure multi-agent is enabled in `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

Start a new session after installing.

## Usage

Ask for the work and invoke the skill:

```
Use the orchestrate skill. Build a CLI that syncs my Notion tasks to a
local SQLite database, with tests.
```

In Claude Code you can also just describe a multi-step task; the skill's
description tells Claude when to load it.

**Codex note:** Codex only spawns subagents when you explicitly ask, so
mention the skill (`$orchestrate`) or say "use subagents" in your prompt.

## When Foreman stays out of the way

The lead does the work itself when:

- the change touches one or two files,
- the parts are tightly coupled,
- the task needs architectural judgment, or
- you asked a quick question.

Delegation has overhead: every subagent starts with no context. For small
tasks, doing it directly is cheaper.

## Customizing

- **Change models:** edit `model:` in `plugins/foreman/agents/*.md` (Claude
  Code) or `model =` in `plugins/foreman/codex/agents/*.toml` (Codex).
- **Add an agent:** add a file in the same folder, then list it in the
  "Your team" table in `skills/orchestrate/SKILL.md`.

## Repository layout

```
foreman/
├── .claude-plugin/marketplace.json     Claude Code marketplace
├── .agents/plugins/marketplace.json    Codex marketplace
├── plugins/foreman/
│   ├── .claude-plugin/plugin.json
│   ├── .codex-plugin/plugin.json
│   ├── skills/orchestrate/SKILL.md     shared by both tools
│   ├── agents/*.md                     Claude Code subagents
│   └── codex/agents/*.toml             Codex subagents
└── scripts/install-codex-agents.sh
```

## What it runs and sends

Foreman is Markdown instructions only (plus the optional Codex install
script, which copies three TOML files into `~/.codex/agents/`). It has no
hooks, no MCP servers, and makes no network calls of its own.

## Roadmap

- [ ] Benchmark: the same task set run lead-only vs. with Foreman, comparing
      cost, test pass rate, and wall-clock time.
- [ ] Optional delegation to a different vendor's CLI (e.g., Codex from
      Claude Code) for second opinions.

## License

MIT
