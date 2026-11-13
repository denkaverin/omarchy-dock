# Dock

A fork of Omarchy's built-in `omarchy.dock` (the dock shown on floating
workspaces) with two things the stock dock has no setting for:

- **Configurable icon size** — read from `dock.iconSize` in
  `~/.config/omarchy/shell.json` and applied live, no restart.
- **Larger app-grid icons** — 72 px instead of 56 px, so the grid of installed
  apps reads better on a HiDPI panel.

Everything else is the stock dock: pinned and running apps, drag to reorder,
app menus, the all-apps grid, uninstall.

## Why a fork

The stock dock hard-codes its icon size (`36 * Style.fontScale`), and cloning
the plugin is Omarchy's supported way to customize it. Two workarounds come
with the clone and are included here:

1. **Config access.** A cloned plugin gets a scoped `shell` object that exposes
   `barConfig` and `idleConfig` but not `shellConfig`, so the stock dock code
   silently sees an empty dock config. `Dock.qml` reads its own section of
   `shell.json` (and the shipped defaults) directly instead, which keeps
   `pinned`, `position`, `autohide` and `iconSize` working.
2. **App library.** A cloned plugin only receives `shell.appLibrary` when it
   declares the `menu` kind, which the dock needs for its app grid. This plugin
   therefore declares `menu` and ships an empty `StubMenu.qml` entry point that
   is never summoned.

## Requirements

- Omarchy 4.5+ with the Quickshell shell (tested with Omarchy 4.5.0-3,
  Quickshell 0.3.2, Hyprland 0.56.2).

## Install

```bash
omarchy plugin add https://github.com/denkaverin/omarchy-dock.git --enable --yes
omarchy restart shell
```

This replaces the built-in dock; it does not touch your `dock` settings in
`~/.config/omarchy/shell.json` (pinned apps, position, autohide, icon size).

## Update

```bash
omarchy plugin update denkaverin.dock
```

## Remove

Switch back to the stock dock:

```bash
omarchy plugin disable denkaverin.dock
omarchy plugin enable omarchy.dock
```

Then, if you want the files gone: `omarchy plugin remove denkaverin.dock`.

## Configure the icon size

Set `dock.iconSize` in `~/.config/omarchy/shell.json` (logical pixels, 16–96):

```json
{
  "dock": {
    "iconSize": 44,
    "pinned": ["org.gnome.Nautilus", "chromium"]
  }
}
```

The running dock picks it up immediately. A small helper is included in
`extras/` for the same thing from a terminal:

```bash
install -Dm755 extras/omarchy-dock-size ~/.local/bin/omarchy-dock-size
omarchy-dock-size 44     # set
omarchy-dock-size        # print the current value
omarchy-dock-size reset  # back to the default 42
```

`extras/omarchy-menu.jsonc` adds `Appearance → Dock → Dock Size` with presets
and a custom prompt. Merge those lines into
`~/.config/omarchy/extensions/omarchy-menu.jsonc`.

## Notes

- The app-grid icon size is a constant in `AppGrid.qml` (72). Change it if you
  prefer the stock 56.
- Derived from Omarchy's `omarchy.dock` (MIT, see `LICENSE`).
