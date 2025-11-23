
# nikolasyugi_kicad_template

This repository holds a KiCad project template used for PCB and schematic starting points.

**Purpose:** keep template files under version control and make them available to KiCad's templates directory via a symlink so updates here are immediately reflected in KiCad.

**Contents:**
- `nikolasyugi_kicad_template.kicad_pcb` - PCB file
- `nikolasyugi_kicad_template.kicad_sch` - Schematic file
- `meta/template.json` and `meta/info.html` - template metadata

## Installing / Using the template

Goal: create a symbolic link from the checked-out copy of this repository into KiCad's templates folder so that when you `git pull` or otherwise update this repo, KiCad will see the changes immediately.

---

This repository includes a small helper script, `install-template.sh`, which automates creating, replacing, and removing the symlink. The script defaults are:

- `REPO_PATH="/Users/nikolasyugi/Documents/projects/nikolasyugi_kicad_template"`
- `KICAD_TEMPLATE_DIR="~/Documents/KiCad/9.0/template"`

Basic usage:

1. Make the script executable (one-time):

```sh
chmod +x install-template.sh
```

2. Install (create or replace the symlink):

```sh
./install-template.sh install
```

3. Remove the symlink created by the script:

```sh
./install-template.sh remove
```

4. Show status of the link and current configuration:

```sh
./install-template.sh status
```

Notes:
- The script expands `~` in `KICAD_TEMPLATE_DIR` and `REPO_PATH` to `$HOME`.
- It uses `ln -sfn` to safely replace any existing symlink. If the destination exists and is not a symlink, the script will still replace it because of `-f`; be cautious if you have non-link data at the destination.

## Notes
- This approach keeps a live link to the working repository. If you clone the repo elsewhere, update the symlink accordingly.
- If you prefer not to symlink, you can copy files into KiCad's templates folder, but then updates will not propagate automatically.