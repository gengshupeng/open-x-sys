#!/bin/sh
set -eu

HOST_NAME=""
DESTINATION=""
ACTION="install"
LANGUAGE="en-US"
LANGUAGE_SET="false"

usage() {
  cat <<'EOF'
OpenXSys installer

  --host codex|claude-code|agents
  --destination PATH
  --language en-US|zh-CN
  --update
  --check
  --uninstall
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --host) [ "$#" -ge 2 ] || { echo "--host requires a value" >&2; exit 2; }; HOST_NAME="$2"; shift 2 ;;
    --destination) [ "$#" -ge 2 ] || { echo "--destination requires a value" >&2; exit 2; }; DESTINATION="$2"; shift 2 ;;
    --language) [ "$#" -ge 2 ] || { echo "--language requires a value" >&2; exit 2; }; LANGUAGE="$2"; LANGUAGE_SET="true"; shift 2 ;;
    --update) [ "$ACTION" = "install" ] || { echo "Choose only one action." >&2; exit 2; }; ACTION="update"; shift ;;
    --check) [ "$ACTION" = "install" ] || { echo "Choose only one action." >&2; exit 2; }; ACTION="check"; shift ;;
    --uninstall) [ "$ACTION" = "install" ] || { echo "Choose only one action." >&2; exit 2; }; ACTION="uninstall"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

case "$LANGUAGE" in en-US|zh-CN) ;; *) echo "Unknown language: $LANGUAGE" >&2; exit 2 ;; esac

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPOSITORY_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
VERSION=$(tr -d '\r\n' < "$REPOSITORY_ROOT/VERSION")

if [ -z "$DESTINATION" ]; then
  if [ -z "$HOST_NAME" ]; then
    if [ -d "$HOME/.codex" ]; then HOST_NAME="codex"
    elif [ -d "$HOME/.claude" ]; then HOST_NAME="claude-code"
    else HOST_NAME="agents"
    fi
  fi
  case "$HOST_NAME" in
    codex) DESTINATION="$HOME/.codex/skills" ;;
    claude-code) DESTINATION="$HOME/.claude/skills" ;;
    agents) DESTINATION="$HOME/.agents/skills" ;;
    *) echo "Unknown host: $HOST_NAME" >&2; exit 2 ;;
  esac
fi

TARGET="$DESTINATION/open-x-sys"

installed_version() {
  [ -f "$1/SKILL.md" ] || return 1
  sed -n 's/^  version: "\([^"]*\)"[[:space:]]*$/\1/p' "$1/SKILL.md" | head -n 1
}

installed_edition() {
  [ -f "$1/SKILL.md" ] || return 1
  sed -n 's/^  edition: \([^[:space:]]*\)[[:space:]]*$/\1/p' "$1/SKILL.md" | head -n 1
}

if [ "$ACTION" = "check" ]; then
  if INSTALLED=$(installed_version "$TARGET"); then
    EDITION=$(installed_edition "$TARGET" || printf 'unknown')
    echo "Installed: OpenXSys $INSTALLED [$EDITION]"
    echo "Location: $TARGET"
  else
    echo "Not installed: $TARGET"
  fi
  exit 0
fi

if [ "$ACTION" = "update" ] && [ "$LANGUAGE_SET" = "false" ]; then
  CURRENT_EDITION=$(installed_edition "$TARGET" || printf '')
  case "$CURRENT_EDITION" in en-US|zh-CN) LANGUAGE="$CURRENT_EDITION" ;; esac
fi

if [ "$LANGUAGE" = "zh-CN" ]; then SOURCE="$REPOSITORY_ROOT/skills/open-x-sys.zh-CN"
else SOURCE="$REPOSITORY_ROOT/skills/open-x-sys"
fi
[ -f "$SOURCE/SKILL.md" ] || { echo "Release source not found: $SOURCE" >&2; exit 1; }

STAMP="$(date -u +%Y%m%d-%H%M%S)-$$"

if [ "$ACTION" = "uninstall" ]; then
  if [ ! -e "$TARGET" ]; then echo "Not installed: $TARGET"; exit 0; fi
  BACKUP="$TARGET.removed-$STAMP"
  mv "$TARGET" "$BACKUP"
  echo "OpenXSys was removed from the host."
  echo "Recoverable backup: $BACKUP"
  echo "User-owned .openxsys systems, works, and data remain unchanged."
  exit 0
fi

if [ -e "$TARGET" ] && [ "$ACTION" != "update" ]; then
  INSTALLED=$(installed_version "$TARGET" || printf 'unknown')
  EDITION=$(installed_edition "$TARGET" || printf 'unknown')
  echo "Target already exists (version $INSTALLED, edition $EDITION): $TARGET" >&2
  echo "Run again with --update." >&2
  exit 1
fi

mkdir -p "$DESTINATION"
STAGING="$DESTINATION/open-x-sys.installing-$STAMP-$$"
BACKUP=""
[ ! -e "$STAGING" ] || { echo "Staging path already exists: $STAGING" >&2; exit 1; }

cleanup_staging() { if [ -e "$STAGING" ]; then rm -rf -- "$STAGING"; fi; }
trap cleanup_staging EXIT HUP INT TERM

cp -R "$SOURCE" "$STAGING"
STAGED_VERSION=$(installed_version "$STAGING" || printf 'unknown')
STAGED_EDITION=$(installed_edition "$STAGING" || printf 'unknown')
if [ "$STAGED_VERSION" != "$VERSION" ] || [ "$STAGED_EDITION" != "$LANGUAGE" ]; then
  echo "Staged Skill identity mismatch: expected $VERSION [$LANGUAGE]." >&2
  exit 1
fi

if [ -e "$TARGET" ]; then BACKUP="$TARGET.backup-$STAMP"; mv "$TARGET" "$BACKUP"; fi
if ! mv "$STAGING" "$TARGET"; then
  if [ -n "$BACKUP" ] && [ -e "$BACKUP" ] && [ ! -e "$TARGET" ]; then mv "$BACKUP" "$TARGET"; fi
  exit 1
fi
trap - EXIT HUP INT TERM

INSTALLED=$(installed_version "$TARGET" || printf 'unknown')
EDITION=$(installed_edition "$TARGET" || printf 'unknown')
if [ "$INSTALLED" != "$VERSION" ] || [ "$EDITION" != "$LANGUAGE" ]; then
  echo "Installed Skill identity mismatch: expected $VERSION [$LANGUAGE]." >&2
  exit 1
fi

echo "OpenXSys $VERSION [$LANGUAGE] installed."
echo "Location: $TARGET"
[ -n "$BACKUP" ] && echo "Previous version backup: $BACKUP"
if [ "$LANGUAGE" = "zh-CN" ]; then echo "现在可以直接说：给……开启一个系统。"
else echo "Now say: Open a system for ..."
fi
