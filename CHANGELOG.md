# Changelog

## 1.2.0

### Added
- Custom options window using Blizzard's `PortraitFrameTemplate` — includes
  the addon icon (Garrote) as a circular portrait in the top-left corner.
- Sliders and checkboxes now apply **live**: dragging the ring size, width,
  spacing or gap slider updates the display immediately, no `/reload` needed.
- Async chain rebuild in chunks (8 `AuraContainer` per frame) to eliminate
  the FPS drop that occurred when releasing a geometry slider.

### Changed
- Options window no longer uses Blizzard's Settings API (`Settings.RegisterCanvasLayoutCategory`).
  This removes the `ADDON_ACTION_BLOCKED` error when opening in combat.
  The window can now be opened any time.
- Left-click on the minimap icon **toggles** the window (open ↔ close) instead
  of just opening it.
- Minimap icon is now perfectly circular (native `TempPortraitAlphaMask`) and
  sits outside the minimap border, similar to RaiderIO.
- All user-facing text is now in English.

### Fixed
- `buildChainAsync` error: `attempt to call a nil value` because `phaseB` was
  referenced before its declaration. Now uses forward declarations.
- `OnEvent` in Tracker no longer errors if an unhandled event fires.
- `UNIT_FLAGS` and `UNIT_THREAT_LIST_UPDATE` no longer trigger a rescan for
  every unit in the game (pets, totems, NPCs). Only `nameplateN` units do.
- `RBTDB` is now initialized with `_G.RBTDB = _G.RBTDB or {}` to avoid
  edge-case failures on some clients.
- Options window close button now hides the panel instead of just the title bar.

## 1.1.0

### Added
- Minimap icon (Garrote) with left-click options, right-click lock and drag-to-move.
- Options panel integrated into the game's Settings menu (ESC -> Options -> AddOns -> RBT).
- Sliders for size, ring width, segment gap and max enemies.
- Checkboxes for combat-only, lock, debug and minimap visibility.
- `/rbt` now opens the options panel instead of toggling the lock.
- Added `/rbt lock` and `/rbt unlock` explicit commands.

## 1.0.0

- First release.
- Garrote and Rupture rings with one segment per engaged enemy, filling clockwise.
- Bleeding/engaged count on each icon.
- Fill colour by coverage: red, then green at 25%, blue at 50%, purple at 75%, orange at 100%.
- Slash commands for position, size, ring width, segment gap and enemy cap.