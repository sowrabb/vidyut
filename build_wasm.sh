#!/bin/bash

# Flutter WebAssembly Build Script for Vidyut
echo "Building Vidyut for WebAssembly..."

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for WebAssembly
echo "Building WebAssembly version..."
flutter build web --dart-define=FLUTTER_WEB_USE_SKIA=true --release

echo "Build completed!"
echo "To serve the app locally, run:"
echo "cd build/web && python3 -m http.server 8000"
echo "Then open http://localhost:8000 in your browser" 