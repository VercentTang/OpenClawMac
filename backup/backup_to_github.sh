#!/usr/bin/env bash
set -euo pipefail

# === Config ===
# Change this to the folder you want to back up.
BACKUP_DIR="${BACKUP_DIR:-/Users/vercent/.openclaw/workspace}"
BRANCH="${BRANCH:-main}"

# Optional: set a repo remote via env (preferred) or edit the git remote manually.
#   export GITHUB_REMOTE_URL="git@github.com:<user>/<repo>.git"
GITHUB_REMOTE_URL="${GITHUB_REMOTE_URL:-}"

STAMP="$(date '+%Y-%m-%d %H:%M:%S')"

cd "$BACKUP_DIR"

if [ ! -d .git ]; then
  echo "[backup] Initializing git repo in $BACKUP_DIR"
  git init
  git checkout -b "$BRANCH" 2>/dev/null || true
fi

# Ensure remote exists if provided
if [ -n "$GITHUB_REMOTE_URL" ]; then
  if git remote get-url origin >/dev/null 2>&1; then
    true
  else
    git remote add origin "$GITHUB_REMOTE_URL"
  fi
fi

# Basic sanity
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[backup] Not a git repo: $BACKUP_DIR" >&2
  exit 2
fi

# Commit changes (only when there is something to commit)
git add -A
if git diff --cached --quiet; then
  echo "[backup] No changes to commit. ($STAMP)"
  exit 0
fi

git commit -m "auto backup: $STAMP" >/dev/null

# Push (only if origin exists)
if git remote get-url origin >/dev/null 2>&1; then
  git push -u origin "$BRANCH"
  echo "[backup] Pushed to origin/$BRANCH ($STAMP)"
else
  echo "[backup] Committed locally but no origin remote set. ($STAMP)"
  echo "[backup] Set origin or export GITHUB_REMOTE_URL and rerun." 
fi
