local respawnCoords = vector4(-1045.0, -2750.0, 21.0, 0.0)

local function revivePlayer()
    TriggerEvent('hospital:client:Revive')
    SetEntityHealth(PlayerPedId(), 200) 
    ClearPedBloodDamage(PlayerPedId()) 
    SetEntityInvincible(PlayerPedId(), false) 
end

local function respawnPlayer()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    SetEntityCoords(PlayerPedId(), respawnCoords.x, respawnCoords.y, respawnCoords.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), respawnCoords.w)

    revivePlayer()

    DoScreenFadeIn(500)
end

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim = data[1]
        if victim == PlayerPedId() then
            local playerHealth = GetEntityHealth(victim)
            if playerHealth <= 0 then

                Wait(5000)
                respawnPlayer()
            end
        end
    end
end)