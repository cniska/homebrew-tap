# Homebrew Tap

Homebrew formulae for my projects.

```bash
brew tap cniska/tap
```

## Acolyte

A terminal-first AI coding agent — [acolyte.sh](https://acolyte.sh).

```bash
brew install cniska/tap/acolyte
```

The installed command is a launcher that runs whichever is newer: this formula's binary, or a build Acolyte staged in its data directory. A self-update never writes into the Cellar, and `brew upgrade` takes precedence whenever the formula is ahead. See [Updates](https://github.com/cniska/acolyte/blob/main/docs/updates.md).

## agent-gates

Commit gates for coding agents: git hooks that refuse a bad commit locally, and CI workflows that judge the same — [cniska/agent-gates](https://github.com/cniska/agent-gates).

```bash
brew install cniska/tap/agent-gates
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-gates` takes each release. See [Releasing](https://github.com/cniska/agent-gates/blob/main/docs/releasing.md).

## agent-record

Session record for coding agents: every past session on this machine, queryable and joined to its commits — [cniska/agent-record](https://github.com/cniska/agent-record).

```bash
brew install cniska/tap/agent-record
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-record` takes each release. See [Releasing](https://github.com/cniska/agent-record/blob/main/docs/releasing.md).

## agent-worktree

Task worktrees for coding agents: one checkout per task, set up and torn down by the project's own commands — [cniska/agent-worktree](https://github.com/cniska/agent-worktree).

```bash
brew install cniska/tap/agent-worktree
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-worktree` takes each release. See [Releasing](https://github.com/cniska/agent-worktree/blob/main/docs/releasing.md).

## agent-task

Task tracking for coding agents: the tasks running in parallel, each with its repo and the brief it started from — [cniska/agent-task](https://github.com/cniska/agent-task).

```bash
brew install cniska/tap/agent-task
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-task` takes each release. See [Releasing](https://github.com/cniska/agent-task/blob/main/docs/releasing.md).

## agent-ship

Releases for coding agents: cut a release, wait for its CI, and confirm it reached every channel — [cniska/agent-ship](https://github.com/cniska/agent-ship).

```bash
brew install cniska/tap/agent-ship
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-ship` takes each release. See [Releasing](https://github.com/cniska/agent-ship/blob/main/docs/releasing.md).
