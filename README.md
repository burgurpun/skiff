# skiff
## A Ship of Harkinian Flatpak

Flatpak manifest for building a local flatpak bundle of Shipwright that builds from source.
The manifest also handles the .desktop file and icon required for normal install, no other requirements except the shared-modules repo. 

https://github.com/HarbourMasters/Shipwright

### Requirements
- Run from Linux install. 
- Flatpak & flatpak-builder packages installed.
- Flathub repo added.
- both Flathub packages installed.
    - com.freedesktop.Platform (25.08)
    - com.freedesktop.Sdk (25.08)

### Build Script (flatpak-build.sh)
- Clean workspace. Deletes any previous soh-repo, build-dir, and .flatpak-builder directories to guarantee a fresh build.
- Run flatpak-builder. Consumes the com.harbourmasters.Shipwright.yml manifest, producing a local repository (soh-repo).
- Bundle. Calls flatpak build-bundle to create a single distributable .flatpak file.

Result: After the script finishes, you will have com.harbourmasters.Shipwright.flatpak ready for distribution or local testing.

### Build and test

Clone the repository

`git clone <this repo URL>`

`cd skiff`

Make the script executable

`chmod +x build-shipwright.sh`

Run the build (alternatively manually run the included commands). 

`./build-shipwright.sh`

Install the resulting Flatpak

`flatpak install ./com.harbourmasters.Shipwright.flatpak`

Launch the installed app from app menu, or:

`cd ~`

`flatpak run com.harbourmasters.Shipwright`

### Known issue
- RUN: If running installed app from terminal, it will generate the config files from current directory. Change back to home or ~ before running app.
- BUILD: the flatpak-builder --install-deps-from=flathub flag was giving me errors. Omitted and added to requirements instead.
- BUILD: missing metadata XML. https://docs.flathub.org/docs/for-app-authors/metainfo-guidelines 
- SOURCE: Missing License files required for Flathub publishing. 
