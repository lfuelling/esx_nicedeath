ESX = nil

--- Event to get the ESX object
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

--- Death event listener
ESX.RegisterServerCallback('esx_nicedeath:onDeath', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.RemoveCash then
        if xPlayer.getMoney() > 0 then
            xPlayer.removeMoney(xPlayer.getMoney())
        end
    end

    if Config.RemoveItems then
        for i = 1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
            end
        end
    end

    local weapons = {}
    if Config.KeepWeapons then
        -- save weapons & restore 3s later to bypass spawnmanager
        for i = 1, #xPlayer.getLoadout(), 1 do
            table.insert(weapons, xPlayer.getLoadout()[i])
        end
        Citizen.CreateThread(function()
            Citizen.Wait(3000)
            for i = 1, #weapons, 1 do
                if weapons[i].label ~= nil then
                    xPlayer.addWeapon(weapons[i].name, weapons[i].ammo)
                    for j = 1, #weapons[i].components, 1 do
                        xPlayer.addWeaponComponent(weapons[i].name, weapons[i].components[j])
                    end
                end
            end
        end)
    else
        for i = 1, #xPlayer.loadout, 1 do
            xPlayer.removeWeapon(xPlayer.getLoadout()[i].name)
        end
    end

    cb()
end)
