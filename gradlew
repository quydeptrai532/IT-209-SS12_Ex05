#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
VERSION=8.14.3
DIST_DIR="${GRADLE_USER_HOME:-$HOME/.gradle}/ci-matrix-distributions/gradle-$VERSION"
if [ ! -x "$DIST_DIR/bin/gradle" ]; then
  command -v curl >/dev/null 2>&1 || { echo 'curl is required'; exit 1; }
  command -v unzip >/dev/null 2>&1 || { echo 'unzip is required'; exit 1; }
  mkdir -p "$(dirname "$DIST_DIR")"
  ZIP="$(mktemp)"
  trap 'rm -f "$ZIP"' EXIT HUP INT TERM
  curl -fL --retry 3 "https://services.gradle.org/distributions/gradle-$VERSION-bin.zip" -o "$ZIP"
  unzip -q -o "$ZIP" -d "$(dirname "$DIST_DIR")"
  rm -f "$ZIP"
  trap - EXIT HUP INT TERM
fi
exec "$DIST_DIR/bin/gradle" "$@"
