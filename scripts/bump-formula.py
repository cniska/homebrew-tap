#!/usr/bin/env python3
"""Repin a formula's release URLs and checksums to one tag."""

import re
import sys

RELEASE_URL = re.compile(r'https://github\.com/([^/"]+/[^/"]+)/releases/download/([^/"]+)/')


def asset_pin(repo):
    return re.compile(
        rf'url "https://github\.com/{re.escape(repo)}/releases/download/[^/"]+/(?P<asset>[^"]+)"\n'
        r'(?P<indent>[ \t]*)sha256 "[0-9a-f]{64}"'
    )


def read_digests(path):
    digests = {}
    with open(path) as sums:
        for line in sums:
            digest, name = line.split()
            digests[name.lstrip("*")] = digest
    return digests


def repin(formula, repo, tag, digests):
    pinned = RELEASE_URL.findall(formula)
    if not pinned:
        raise SystemExit("the formula pins no release URLs")
    others = sorted({pinned_repo for pinned_repo, _ in pinned} - {repo})
    if others:
        raise SystemExit(f"the formula pins releases of {others}, not {repo}")

    def pin(match):
        asset = match.group("asset")
        if asset not in digests:
            raise SystemExit(f"{asset} is missing from the checksum file")
        return (
            f'url "https://github.com/{repo}/releases/download/{tag}/{asset}"\n'
            f'{match.group("indent")}sha256 "{digests[asset]}"'
        )

    repinned = asset_pin(repo).sub(pin, formula)

    tags = {pinned_tag for _, pinned_tag in RELEASE_URL.findall(repinned)}
    if tags != {tag}:
        raise SystemExit(f"the formula still pins {sorted(tags - {tag})} after the rewrite")

    return repinned


def main(formula_path, repo, sums_path, tag):
    with open(formula_path) as formula:
        original = formula.read()

    repinned = repin(original, repo, tag, read_digests(sums_path))
    if repinned == original:
        return

    with open(formula_path, "w") as formula:
        formula.write(repinned)


if __name__ == "__main__":
    main(*sys.argv[1:])
