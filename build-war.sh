#!/bin/bash
set -e
WAR_OUTPUT_DIR="./target"
WAR_FILE_NAME="your-app.war"
SOURCE_DIR="./src"

mkdir -p "$WAR_OUTPUT_DIR"
cd "$SOURCE_DIR"
zip -r "../$WAR_OUTPUT_DIR/$WAR_FILE_NAME" .
cd ..
echo "WAR file built: $WAR_OUTPUT_DIR/$WAR_FILE_NAME"
