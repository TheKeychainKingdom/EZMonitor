#!/bin/bash
# ezmonitor-build-plasmoid.sh

set -e

SRC_DIR="/home/alec/projects/EZMonitor/package"
TMP_DIR="$(mktemp -d)"
PLASMOID_ID=$(jq -r '.KPlugin.Id' "$SRC_DIR/metadata.json")
VERSION=$(jq -r '.KPlugin.Version' "$SRC_DIR/metadata.json")

OUTFILE="${PLASMOID_ID}-${VERSION}.plasmoid"

echo "Plasmoid-ID: $PLASMOID_ID"
echo "Version: $VERSION"
echo "Erzeuge: $OUTFILE"

# Nur benötigte Dateien kopieren
mkdir -p "$TMP_DIR/$PLASMOID_ID"
cp -r "$SRC_DIR/contents" "$TMP_DIR/$PLASMOID_ID/"
cp "$SRC_DIR/metadata.json" "$TMP_DIR/$PLASMOID_ID/"

# Paket erstellen
cd "$TMP_DIR"
zip -r "$OLDPWD/$OUTFILE" "$PLASMOID_ID"

# Aufräumen
cd "$OLDPWD"
rm -rf "$TMP_DIR"

echo "✔️ Fertig: $OUTFILE"
