# esx_nicedeath [![Latest Release](https://img.shields.io/github/v/release/lfuelling/esx_nicedeath?include_prereleases)](https://github.com/lfuelling/esx_nicedeath/releases)

- **If you fork this, you won't get updates.** 
    - **Consider Starring instead if you don't want to make a contribution.**

## EN
ESX plugin that makes death a little bit more configurable.

This plugin has the following features:

- Enables the death screen and lets you see the ragdolling
- Configurable respawn cooldown
- Weapons, Items, Cash can be removed on death (but also kept)
- Configurable respawn location
    - Mt. Zonah by default
    - Respawn at random hospital can be enabled in [config.lua](config.lua).
    
## ES
ESX plugin que hace la muerte un poco mas configurable.

Este plugin tiene las siguientes opciones:

- Habilita la pantalla de muerte y te permite ver el cuerpo
- Tiempo de reaparicion configurable
- Armas, Inventario, y dinero pueden ser removidos en un fallecimiento (tambien permite que se queden).
- Lugar de reaparicion configurable.
    - El hospital de Mt. Zonah, es la localidad de reaparicion por defecto.
    - La reaparición en un hospital aleatorio se puede habilitar en [config.lua](config.lua).

## NL
ESX plugin die de dood wat meer configureerbaar maakt.

Deze plugin heeft de volgende mogelijkheden:

- Maakt het 'Wasted' scherm beschikbaar met de tekst 'Overleden'. Deze is aan te passen in de Config
- Cooldown tijd in te stellen
- Wapens, items en geld zijn aan te passen
- Vaste spawnpunt in te stellen

## Installation

1. Download this repo into your `resources/[esx/]` folder
2. Add `start esx_nicedeath` to your `server.cfg`
3. Modify `spawnmanager` to disable death spawn:
    1. find `resources/[managers]/spawnmanager/spawnmanager.lua`
    2. replace line 345
        - Old: `if (diedAt and (math.abs(GetTimeDifference(GetGameTimer(), diedAt)) > 2000)) or respawnForced then`
        - New: `if respawnForced then`
    3. Remember to redo this once you update the `server-data` repo!
