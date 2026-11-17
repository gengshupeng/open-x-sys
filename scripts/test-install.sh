#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TEMP_BASE=$(CDPATH= cd -- /tmp && pwd)
FIXTURE=$(mktemp -d "$TEMP_BASE/openxsys-package.XXXXXXXX")
assert_target() {
  resolved=$(realpath -m "$1")
  case "$resolved" in "$FIXTURE"/*/open-x-sys) ;; *) echo "Target outside fixture" >&2; exit 1 ;; esac
}
mkdir -p "$FIXTURE/.openxsys"
printf '%s' 'Keep this personal system.' > "$FIXTURE/.openxsys/SYSTEM.md"
for edition in open-x-sys open-x-sys.zh-CN; do
  unpacked="$FIXTURE/$edition-unpacked"
  mkdir -p "$unpacked" "$FIXTURE/$edition-installed"
  unzip -q "$ROOT/dist/$edition.zip" -d "$unpacked"
  source="$unpacked/$edition"
  target="$FIXTURE/$edition-installed/open-x-sys"
  assert_target "$target"
  cp -R "$source" "$target"
  for file in SKILL.md VERSION LICENSE methods/2-explain/first_principles.md display/signature.md; do test -f "$target/$file"; done
  test "$(cat "$target/VERSION")" = "$(cat "$ROOT/VERSION")"
  printf '%s' 'Old installed copy.' > "$target/SKILL.md"
  assert_target "$target"
  rm -rf "$target"
  cp -R "$source" "$target"
  diff -r "$source" "$target"
  assert_target "$target"
  rm -rf "$target"
  test ! -e "$target"
  test "$(cat "$FIXTURE/.openxsys/SYSTEM.md")" = 'Keep this personal system.'
  printf '%s\n' "$edition: ZIP folder import, replacement and removal passed; personal system preserved."
done
printf '%s\n' "Fixture: $FIXTURE"
