ESX = nil
local PlayerData = {}
local isMenuOn = false

local display = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer   
end)


--very important cb 
RegisterNUICallback("exit", function(data)
	display = false
	isMenuOn = false
	
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "enable",
		isVisible = "none"
	})
	
	SendNUIMessage({
		type = "enable_2",
		isVisible = "none"
	})
end)

RegisterNetEvent('illegalshop:exit')
AddEventHandler('illegalshop:exit', function()
	display = false
	isMenuOn = false
	
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "enable",
		isVisible = "none"
	})
	
	SendNUIMessage({
		type = "enable_2",
		isVisible = "none"
	})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		TriggerServerEvent("illegalshop:refreshItems")
	end
end)

Citizen.CreateThread(function()
	RequestModel(Config.NPCHash)
	
	while not HasModelLoaded(Config.NPCHash) do
		Wait()
	end

	npc = CreatePed(1, Config.NPCHash, Config.NPCCoord.x, Config.NPCCoord.y, Config.NPCCoord.z, 60, false, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	SetPedDiesWhenInjured(npc, false)
	SetPedCanPlayAmbientAnims(npc, true)
	SetPedCanRagdollFromPlayerImpact(npc, false)
	SetEntityInvincible(npc, true)
	FreezeEntityPosition(npc, true)
	TaskStartScenarioInPlace(npc, "WORLD_HUMAN_SMOKING", 0, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		local coords = GetEntityCoords(PlayerPedId())
		local distance = GetDistanceBetweenCoords(coords, Config.NPCCoord.x, Config.NPCCoord.y, Config.NPCCoord.z + 1.0, true)
		
		if distance <= 2.5 then
			ESX.Game.Utils.DrawText3D({x = Config.NPCCoord.x, y = Config.NPCCoord.y, z = Config.NPCCoord.z + 2.0}, Config.NPCName, 0.8, 4)
		
			if distance <= 1 then
				if IsControlJustReleased(1, 51) then
					if Config.JobOrNot then
						if PlayerData.job.name == Config.JobName then
							if isMenuOn == false then
								SetNuiFocus(true, true)
								SendNUIMessage({
									type = "enable_2",
									isVisible = "block"
								})
								isMenuOn = true
								display = true
							end
						end
					else
						if isMenuOn == false then
							SetNuiFocus(true, true)
							SendNUIMessage({
								type = "enable_2",
								isVisible = "block"
							})
							isMenuOn = true
							display = true
						end
					end
				end
			end
		end
    end
end)

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function targyeladas()
	local elements = {}
	for k,v in ipairs(Config.SellItems) do
		table.insert(elements, {label = v.label, name = v.name, value = v.value, type = v.type, min = v.min, max = v.max, price = v.price})
	end

	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'targyeladas', {
        title    = 'Tárgy Eladása',
        align    = 'left',
        elements = elements
    }, function(data, menu)
		TriggerServerEvent("illegalshop:targyeladas", data.current.name, data.current.value, data.current.price)
    end, function(data, menu)
		menu.close()
	end)
end

RegisterNUICallback("targyeladas", function()
	TriggerEvent("illegalshop:exit")
	targyeladas()
end)
