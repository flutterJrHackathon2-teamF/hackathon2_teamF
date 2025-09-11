#!/bin/bash

echo "Running Flutter pub get..."
flutter pub get

echo "Running code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo "Code generation completed!"
echo "You can now run: flutter run"