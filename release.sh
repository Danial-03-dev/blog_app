#!/bin/bash

# Prevent Git Bash from rewriting / paths on Windows
export MSYS_NO_PATHCONV=1

VERSION="v1.0.0"  # Update for each release

# ----------- Build Android -----------
echo "Building Android APK..."
flutter build apk --release
ANDROID_APK="build/app/outputs/flutter-apk/app-release.apk"

# ----------- Build Windows -----------
echo "Building Windows EXE..."
flutter build windows --release

WIN_FOLDER="build/windows/x64/runner/Release"
if [ ! -d "$WIN_FOLDER" ]; then
    echo "Error: Windows Release folder not found at $WIN_FOLDER"
    exit 1
fi

WIN_ZIP="build/windows/shared_thoughts_windows_$VERSION.zip"
echo "Zipping Windows build using PowerShell..."
powershell.exe -Command "Get-ChildItem '$WIN_FOLDER' | Compress-Archive -DestinationPath '$WIN_ZIP' -Force"

# ----------- Create GitHub Release -----------
echo "Creating GitHub release $VERSION..."
gh release create "$VERSION" \
    "$ANDROID_APK" \
    "$WIN_ZIP" \
    --generate-notes \
    --title "Release $VERSION"

echo "✅ Release $VERSION created successfully!"
echo "Android APK: $ANDROID_APK"
echo "Windows ZIP: $WIN_ZIP"
