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
