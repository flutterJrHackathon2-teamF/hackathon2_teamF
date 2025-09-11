#!/bin/bash
echo "Installing dependencies..."
flutter pub get

echo "Running code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo "Code generation complete! StampDataAdapter should now be available."