ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("illegalshop:targyeladas")
AddEventHandler("illegalshop:targyeladas", function(item, count, price)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local targynev = xPlayer.getInventoryItem(item).label
    local darab = xPlayer.getInventoryItem(item).count
    local selling_price = price * count
    if xPlayer ~= nil then
        if darab >= count then
            --TriggerClientEvent('codem-notification', source,  count.. " "..targynev.. " Eladva "..selling_price.." Dollárért", 3000, "check")	
            TriggerClientEvent('esx:showNotification', _source, count.. " "..targynev.. " Eladva "..selling_price.." Dollárért")

            RegisterServerEvent('eladas-ertesites')
            AddEventHandler('eladas-ertesites', function(count, targynev, selling_price)
              TriggerClientEvent('show-esx-notification', -1, count, targynev, selling_price)
            end)
            
			xPlayer.removeInventoryItem(item, count)
			xPlayer.addAccountMoney('black_money', (selling_price))
          
        end
    end
end)

