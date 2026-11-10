# Changelog

All notable changes to Foreman are documented here. This project follows
[Semantic Versioning](https://semver.org/).

## [0.1.2] - 2026-11-10

### Changed

- Moved the Codex subagent TOML files from `plugins/foreman/codex/agents/`
  to `codex/agents/` at the repo root. The Claude plugin directory doesn't
  allow TOML files inside a plugin, and Claude Code never used them.
  `scripts/install-codex-agents.sh` reads from the new location; Codex users
  install the same way as before.

## [0.1.1] - 2026-11-10

### Fixed

- Codex subagents failed to start: `gpt-5.4-mini` isn't available to Codex
  with a ChatGPT account. They now use `gpt-5.6-luna`.
- Install docs: replaced the outdated `/agents` check, made the Codex
  subagent install an explicit required step, and dropped the
  `multi_agent = true` config step (it's on by default).

### Changed

- README explains that plugin agents load from the plugin, not
  `~/.claude/agents/`, and how to pick a different Codex model
  (`codex debug models`) if `gpt-5.6-luna` isn't available to you.

## [0.1.0] - 2026-11-10

Initial release.

### Added

- `orchestrate` skill, shared by Claude Code and Codex: workflow and
  delegation rules for the lead model.
- Claude Code subagents: `implementer`, `searcher`, `reviewer` (Sonnet).
- Codex subagents (`gpt-5.4-mini`) as TOML files, plus
  `scripts/install-codex-agents.sh` to install them into `~/.codex/agents/`.
- Claude Code marketplace (`.claude-plugin/marketplace.json`) and Codex
  marketplace (`.agents/plugins/marketplace.json`).

[0.1.2]: https://github.com/klee1611/foreman/releases/tag/v0.1.2
[0.1.1]: https://github.com/klee1611/foreman/releases/tag/v0.1.1
[0.1.0]: https://github.com/klee1611/foreman/releases/tag/v0.1.0
