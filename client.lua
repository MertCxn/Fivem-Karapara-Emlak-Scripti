local QBCore = exports['qb-core']:GetCoreObject()
local ScriptData = Config.Emlak

CreateThread(function()
    for k, v in pairs(ScriptData) do
        RequestModel(v.Ped.model)
        local timeout = 5000 -- 5 saniye
        local startTime = GetGameTimer()
        while not HasModelLoaded(v.Ped.model) do
            Wait(1)
            if GetGameTimer() - startTime > timeout then
                print("Model yüklenemedi: " .. v.Ped.model)
                break
            end
        end

        local sellerPed = CreatePed(4, v.Ped.model, v.Ped.coords.x, v.Ped.coords.y, v.Ped.coords.z - 1.0, v.Ped.coords.w, false, true)
        FreezeEntityPosition(sellerPed, true)
        SetEntityInvincible(sellerPed, true)
        SetBlockingOfNonTemporaryEvents(sellerPed, true)

        for i, z in pairs(v.Jobs) do
            exports['qb-target']:AddTargetEntity(sellerPed, {
                options = {
                    {
                        icon = "fas fa-dollar-sign",
                        label = "Sat",
                        action = function()
                            TriggerServerEvent("chivas:server:washMoney") -- QBCore.Key kaldırıldı
                        end,
                        canInteract = function()
                            local playerData = QBCore.Functions.GetPlayerData()
                            if playerData and playerData.job and z == playerData.job.name then
                                return true
                            end
                            return false
                        end,
                    },
                },
                distance = 2.0
            })
        end
    end
end)