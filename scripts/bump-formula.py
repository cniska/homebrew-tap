#!/usr/bin/env python3
"""Repin a formula's release URLs and checksums to one tag."""

import re
import sys

ASSET_PIN = re.compile(
    r'url "https://github\.com/cniska/acolyte/releases/download/[^/"]+/(?P<asset>[^"]+)"\n'
    r'(?P<indent>[ \t]*)sha256 "[0-9a-f]{64}"'
)
RELEASE_TAG = re.compile(r'releases/download/([^/"]+)/')


def read_digests(path):
    digests = {}
    with open(path) as sums:
        for line in sums:
            digest, name = line.split()
            digests[name.lstrip("*")] = digest
    return digests


def repin(formula, tag, digests):
    def pin(match):
        asset = match.group("asset")
        if asset not in digests:
            raise SystemExit(f"{asset} is missing from the checksum file")
        return (
            f'url "https://github.com/cniska/acolyte/releases/download/{tag}/{asset}"\n'
            f'{match.group("indent")}sha256 "{digests[asset]}"'
        )

    repinned = ASSET_PIN.sub(pin, formula)

    tags = set(RELEASE_TAG.findall(repinned))
    if not tags:
        raise SystemExit("the formula pins no release URLs")
    if tags != {tag}:
        raise SystemExit(f"the formula still pins {sorted(tags - {tag})} after the rewrite")

    return repinned


def main(formula_path, sums_path, tag):
    with open(formula_path) as formula:
        original = formula.read()

    repinned = repin(original, tag, read_digests(sums_path))
    if repinned == original:
        return

    with open(formula_path, "w") as formula:
        formula.write(repinned)


if __name__ == "__main__":
    main(*sys.argv[1:])
