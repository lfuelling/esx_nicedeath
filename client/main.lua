ESX = nil
local isDead = false
local soundPlaying = false

--- Thread to get the ESX object
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

--- Utility function that starts the respawn timer
function StartRespawnTimer()
    local respawnTimer = ESX.Math.Round(Config.RespawnTimer / 1000)
    Citizen.CreateThread(function()
        -- respawn timer
        while respawnTimer > 0 and isDead do
            Citizen.Wait(1000)

            if respawnTimer > 0 then
                respawnTimer = respawnTimer - 1
            end
        end
    end)
    Citizen.CreateThread(function()
        local text, timeHeld
        while isDead do
            Citizen.Wait(0)
            if respawnTimer > 0 then
                text = _U('respawn_available_in', formatTimer(respawnTimer))
                drawText(text)
            else
                text = _U('respawn_prompt')
                if IsControlPressed(0, 38) and timeHeld > 60 then
                    doRespawn()
                    break
                end
                if IsControlPressed(0, 38) then
                    timeHeld = timeHeld + 1
                else
                    timeHeld = 0
                end
                drawText(text)
            end
        end
    end)
end

--- Utility function that does the respawn logic
function doRespawn()
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
        ESX.TriggerServerCallback('esx_nicedeath:onDeath', function()
            isDead = false
            ESX.SetPlayerData('loadout', {})
            RespawnPed(PlayerPedId(), Config.RespawnPoint.coords, Config.RespawnPoint.heading)
            StopScreenEffect('DeathFailOut')
            Citizen.Wait(350) -- wait tree fiddy for screen to build
            DoScreenFadeIn(800)
        end)
    end)
end

--- Utility function to respawn a ped
function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    ClearPedLastDamageBone(ped)
    ClearPedTasks(ped)

    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned') -- compatibility with old scripts, should be removed soon
end

--- Utility function to draw text on the screen
function drawText(text)
    SetTextFont(4)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(0.5, 0.8)
end

--- Utility function to format the countdown to mm:ss
function formatTimer(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return 0, 0
    else
        local hours = string.format('%02.f', math.floor(seconds / 3600))
        local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
        local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

        return mins, secs
    end
end

function PlaySoundAndShowMessage()
    Citizen.CreateThread(function()

        PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)

        local wastedMessage = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

        while not HasScaleformMovieLoaded(wastedMessage) do
            Citizen.Wait(0)
        end
        PushScaleformMovieFunction(wastedMessage, "SHOW_SHARD_WASTED_MP_MESSAGE")
        BeginTextComponent("STRING")
        AddTextComponentString("~r~" .. _U('wasted'))
        EndTextComponent()
        PopScaleformMovieFunctionVoid()

        Citizen.Wait(500)

        PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
        while isDead do
            DrawScaleformMovieFullscreen(wastedMessage, 255, 255, 255, 255)
            Citizen.Wait(0)
        end
    end)
end

--- Death event handler
AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
    ESX.UI.Menu.CloseAll()
    StartScreenEffect('DeathFailOut', 0, false)
    ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1)

    PlaySoundAndShowMessage()
    StartRespawnTimer()
end)