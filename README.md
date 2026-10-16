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

Git hooks and GitHub workflows that gate coding agents' commits — [cniska/agent-gates](https://github.com/cniska/agent-gates).

```bash
brew install cniska/tap/agent-gates
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-gates` takes each release. See [Releasing](https://github.com/cniska/agent-gates/blob/main/docs/releasing.md).

## agent-record

Every coding-agent session on this machine, kept verbatim and searchable — [cniska/agent-record](https://github.com/cniska/agent-record).

```bash
brew install cniska/tap/agent-record
```

The installed command is this formula's binary alone, with no self-update: `brew upgrade agent-record` takes each release. See [Releasing](https://github.com/cniska/agent-record/blob/main/docs/releasing.md).
