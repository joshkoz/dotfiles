#!/usr/bin/env bash
set -euo pipefail

FEED_URL="https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json"
TOOL_NAME="roslyn-language-server"

if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet not found. Install dotnet-sdk first." >&2
  exit 1
fi

if dotnet tool list -g | awk '{print $1}' | grep -qx "$TOOL_NAME"; then
  dotnet tool update -g "$TOOL_NAME" --prerelease --source "$FEED_URL"
else
  dotnet tool install -g "$TOOL_NAME" --prerelease --source "$FEED_URL"
fi

echo "Done. Ensure ~/.dotnet/tools is on PATH."
