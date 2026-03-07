#!/usr/bin/env bash

# Populate submodule dir
git submodule update --init --recursive

### 1. Clean / recreate the 'soh-repo' directory
SOH_REPO="./soh-repo"

if [ -d "$SOH_REPO" ]; then
    echo "# Removing existing \"$SOH_REPO\" directory.."
    rm -rf "$SOH_REPO"
fi

echo "# Creating fresh \"$SOH_REPO\" directory.."
mkdir -p "$SOH_REPO"


### 2. Remove leftover build directories
echo "# Removing existing build-dir directory.."
rm -rf ./build-dir 
echo "# Removing existing .flatpak-builder directory.."
rm -rf ./.flatpak-builder

### 3. Start flatpak build from YAML file - this will take awhile
echo "# running flatpak-builder command..."
flatpak-builder --repo=./soh-repo --force-clean build-dir com.harbourmasters.Shipwright.yml

### 4. Builds local .flatpak
echo "# Building .flatpak bundle.."
flatpak build-bundle ./soh-repo com.harbourmasters.Shipwright.flatpak com.harbourmasters.Shipwright --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo

echo "# Build complete. .flatpak file should be available in script dir."
echo "# Install with 'flatpak install ./com.harbourmasters.Shipwright.flatpak'"
echo "# Run via desktop entry, or with 'flatpak run com.harbourmasters.Shipwright' while at home or ~"
