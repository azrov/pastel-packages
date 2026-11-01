#!/bin/sh
# Checks packages.toml: every package is found, has a version and passes its tests.
#   sh check.sh            all packages
#   sh check.sh serial     only these
set -e
here="$(cd "$(dirname "$0")" && pwd)"
export PASTEL_REGISTRY="$here"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
names="$*"
[ -n "$names" ] || names="$(sed -n 's/^\[\([A-Za-z0-9_-]*\)\]$/\1/p' "$here/packages.toml")"
sorted="$(sed -n 's/^\[\([A-Za-z0-9_-]*\)\]$/\1/p' "$here/packages.toml")"
[ "$sorted" = "$(echo "$sorted" | sort)" ] || { echo "error: packages.toml is not in alphabetical order"; exit 1; }
for n in $names; do
  echo "== $n"
  rm -rf "$work/try" && mkdir -p "$work" && cd "$work"
  pastel new console try >/dev/null && cd try
  pastel add "$n"
  pastel deps
  d="$(pastel deps --json | sed -n 's/.*"root":"\([^"]*\)","depth":0.*/\1/p' | head -1)"
  (cd "$d" && pastel test)
done
echo "all packages are fine"
