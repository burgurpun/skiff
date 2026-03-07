# skiff
## A Ship of Harkinian Flatpak

Flatpak manifest for building a local flatpak bundle of Shipwright that builds from source.

https://github.com/HarbourMasters/Shipwright

### Requirements
- A Linux install. 
- Flatpak & flatpak-builder packages installed.
- Flathub repo added.
- both Flathub packages installed.
    - com.freedesktop.Platform (25.08)
    - com.freedesktop.Sdk (25.08)

### Build Script (flatpak-build.sh)
- Prerequisite check. Verifies that flatpak and flatpak-builder are installed. If not, it prints an install hint for Debian/Ubuntu, Fedora, or Arch.
- Flathub remote. Adds the Flathub repository (if it isn't already present) so the required runtimes/SDKs can be pulled.
- Install SDKs. Installs the latest Freedesktop Platform & SDK (adjust the version number if you need a newer one).
- Clean workspace. Deletes any previous soh-repo, build-dir, and .flatpak-builder directories to guarantee a fresh build.
- Run flatpak-builder. Consumes the com.harbourmasters.Shipwright.yml manifest, producing a local repository (soh-repo).
- Bundle. Calls flatpak build-bundle to create a single distributable .flatpak file.

Result: After the script finishes, you will have com.harbourmasters.Shipwright.flatpak ready for distribution or local testing.

### Build and test

Clone the repository

`git clone <this repo>`

`cd [REPO_NAME]`

Make the script executable

`chmod +x build-shipwright.sh`

Run the build - alternatively manually run the included commands. 

`./build-shipwright.sh`

Install the resulting Flatpak

`flatpak install ./com.harbourmasters.Shipwright.flatpak`

Launch the installed app from app menu, or:

`cd ~`

`flatpak run com.harbourmasters.Shipwright`

### Known issue
If running from terminal, it will generate the config files from current directory. 
Change back to home or ~ before running app.
