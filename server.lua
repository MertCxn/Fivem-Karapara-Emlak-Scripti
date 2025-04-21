local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent('chivas:server:washMoney', function(key)
    local Player = QBCore.Functions.GetPlayer(source)
	--if key == QBCore.Key then
		if Player ~= nil then
			if Player.Functions.GetItemByName('karapara').amount >= 10 then
				TriggerClientEvent("QBCore:Notify", source, Player.Functions.GetItemByName('karapara').amount * 100 / 100 .. "$ kara para aklandı!")
				Player.Functions.AddMoney('cash', Player.Functions.GetItemByName('karapara').amount * 100 / 100)
				Player.Functions.RemoveItem('karapara', Player.Functions.GetItemByName('karapara').amount)
			else
				TriggerClientEvent("QBCore:Notify", source, "Yetersiz Miktar!", "error")
			end
		end
end)