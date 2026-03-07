#!/usr/bin/env bash

# ------------------------------------------------------------
# Helper function to print an installation hint for missing tools
# ------------------------------------------------------------
install_hint() {
    local tool=$1
    echo "\"$tool\" is not installed."
    echo "   You can install it with your package manager:"
    echo "     - Debian/Ubuntu: sudo apt install $tool"
    echo "     - Fedora:        sudo dnf install $tool"
    echo "     - Arch Linux:    sudo pacman -S $tool"
    echo "   A reboot may be required. Re-run script afterwards."
}

### 1. Verify that both flatpak and flatpak-builder are present
missing=0

if ! command -v flatpak-builder >/dev/null 2>&1; then
    install_hint "flatpak-builder"
    missing=1
fi

if ! command -v flatpak >/dev/null 2>&1; then
    install_hint "flatpak"
    missing=1
fi

# If either tool is missing, stop further execution
if [ "$missing" -eq 1 ]; then
    echo "Please install the missing tool(s) and run the script again."
    exit 1
fi

### 2. Add the Flathub repository (if not already added)
echo "# Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install deps
echo "# Installing required Flathub SDKs. Pick latest number available - 25.08 at time of writing."
flatpak install com.freedesktop.Platform
flatpak install com.freedesktop.Sdk

### 3. Clean / recreate the 'soh-repo' directory
SOH_REPO="./soh-repo"

if [ -d "$SOH_REPO" ]; then
    echo "# Removing existing \"$SOH_REPO\" directory.."
    rm -rf "$SOH_REPO"
fi

echo "# Creating fresh \"$SOH_REPO\" directory.."
mkdir -p "$SOH_REPO"


### 4. Remove leftover build directories
echo "# Removing existing build-dir directory.."
rm -rf ./build-dir 
echo "# Removing existing .flatpak-builder directory.."
rm -rf ./.flatpak-builder

### 5. Start flatpak build from YAML file - this will take awhile
echo "# running flatpak-builder command..."
flatpak-builder --repo=./soh-repo --force-clean build-dir com.harbourmasters.Shipwright.yml

### 6. Builds local .flatpak
echo "# Building .flatpak bundle.."
flatpak build-bundle ./soh-repo com.harbourmasters.Shipwright.flatpak com.harbourmasters.Shipwright --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo

echo "# Build complete. .flatpak file should be available in script dir."
echo "# Install with 'flatpak install ./com.harbourmasters.Shipwright.flatpak'"
echo "# Run via desktop entry, or with 'flatpak run com.harbourmasters.Shipwright' while at home or ~"
