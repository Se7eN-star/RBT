# RBT - Rogues Bleed Tracker

Garrote and Rupture coverage at a glance for **Assassination Rogues**.

RBT shows two round icons, Garrote and Rupture. Each one has a ring split into
one segment per enemy you are fighting. The ring fills clockwise from 12 o'clock
as more of those enemies carry your bleed, and the icon shows the count, for
example `5/11`.

The fill colour tells you how much of the pack is covered, using WoW's item-quality colours:

| Enemies bleeding | Colour |
|---|---|
| under 25% | red |
| 25% or more | green (uncommon) |
| 50% or more | blue (rare) |
| 75% or more | purple (epic) |
| all of them | orange (legendary) |

## Works with Midnight's aura restrictions

Since 12.0, addons can no longer read enemy auras in combat. RBT never tries.
Blizzard's own aura widgets work out the count, and RBT only arranges what they
draw. No secret value is ever read by addon code.

## Usage

The display appears automatically in combat while you are in Assassination spec.

| Command | Effect |
|---|---|
| `/rbt` | Lock / unlock the frame (drag it while unlocked) |
| `/rbt reset` | Move the frame back to its default position |
| `/rbt combat` | Toggle between enemies you are fighting (default) and every hostile nameplate |
| `/rbt size <px>` | Ring diameter, 16-128 (default 64, needs `/reload`) |
| `/rbt width <px>` | Ring thickness, 1-20 (default 5, needs `/reload`) |
| `/rbt gap <deg>` | Gap between segments, 0-20 (default 4, needs `/reload`) |
| `/rbt max <n>` | Most enemies shown, 1-40 (default 20) |

Enemies count once they are in combat and you have threat on them. Training
dummies never enter combat, so use `/rbt combat` to test on them, and switch it
back afterwards.

Enemies need visible nameplates to be counted.

## License

GNU General Public License v2.0, see `LICENSE.txt`. You are free to use,
modify and share RBT, as long as your version stays under the same license.
