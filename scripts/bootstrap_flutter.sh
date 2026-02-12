#!/usr/bin/env bash
set -euo pipefail

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK is required. Install it from https://flutter.dev/docs/get-started/install" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

if [ ! -d "android" ] || [ ! -d "ios" ]; then
  echo "Generating Flutter platform scaffolding..."
  flutter create --org com.arbat.goldpremium --project-name arbat_gold_premium .
else
  echo "Platform folders already exist. Skipping flutter create."
fi

echo "Done. Run 'flutter pub get' and 'flutter run'."
