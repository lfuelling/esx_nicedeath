# esx_nicedeath

ESX plugin that makes death a little bit more configurable.

This plugin has the following features:

- Enables the death screen and let's you see the ragdolling
- Configurable respawn cooldown
- Weapons, Items, Cash can be removed on death (but also kept)
- Configurable respawn location (mt. zonah by default)

## Installation

1. Download this repo into your `resources/[esx/]` folder
2. Add `start esx_nicedeath` to your `server.cfg`
3. Modify `spawnmanager` to disable death spawn:
    1. find `resources/[managers]/spawnmanager/spawnmanager.lua`
    2. replace line 345
        - Old: `if (diedAt and (math.abs(GetTimeDifference(GetGameTimer(), diedAt)) > 2000)) or respawnForced then`
        - New: `if respawnForced then`
    3. Remember to redo this once you update the `server-data` repo!
