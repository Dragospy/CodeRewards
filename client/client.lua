local ui = false
local rewards = {}
local QBCore = exports['qb-core']:GetCoreObject()

function findVehicles(searchText)
    local foundVehicles = {}
    local text = string.lower(searchText)
    local count = 0 
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if string.find(string.lower(v["name"]), text) ~= nil and count <= 5 then   
            count = count + 1
            print(v["name"])   
            foundVehicles[#foundVehicles+1] = {
                name = v["name"],
                model = v["model"],
            }
        end
    end
    return foundVehicles
end

function findItems(searchText)
    local foundItems = {}
    local text = string.lower(searchText)
    local count = 0 
    for k,v in pairs(QBCore.Shared.Items) do
        if string.find(string.lower(v["label"]), text) ~= nil and count <= 5 then   
            count = count + 1
            print(v["label"])   
            foundItems[#foundItems+1] = {
                label = v["label"],
                name = v["name"],
            }
        end
    end
    print("returned items")
    return foundItems
end

function UpdateRewards()
    SendNUIMessage({
        type = "UpdateRewards",
        rewards = rewards
    })
end

function OpenUI()
    if not ui then
        SendNUIMessage({
            type = "ShowUI"
        })
        SetNuiFocus(true,true)
        ui = true   
    end
end


SpawnVehicle = function(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		RequestModel2(model)

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
		local id      = NetworkGetNetworkIdFromEntity(vehicle)

		SetNetworkIdCanMigrate(id, true)
		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb then
			cb(vehicle)
		end
	end)
end

function RequestModel2(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

GetVehicleProperties = function(vehicle)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		local extras = {}

		for extraId=0, 12 do
			if DoesExtraExist(vehicle, extraId) then
				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
				extras[tostring(extraId)] = state
			end
		end

		return {
			model             = GetEntityModel(vehicle),

			plate             = Trim(GetVehicleNumberPlateText(vehicle)),
			plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

			bodyHealth        = Round(GetVehicleBodyHealth(vehicle), 1),
			engineHealth      = Round(GetVehicleEngineHealth(vehicle), 1),
			tankHealth        = Round(GetVehiclePetrolTankHealth(vehicle), 1),

			fuelLevel         = Round(GetVehicleFuelLevel(vehicle), 1),
			dirtLevel         = Round(GetVehicleDirtLevel(vehicle), 1),
			color1            = colorPrimary,
			color2            = colorSecondary,

			pearlescentColor  = pearlescentColor,
			wheelColor        = wheelColor,

			wheels            = GetVehicleWheelType(vehicle),
			windowTint        = GetVehicleWindowTint(vehicle),
			xenonColor        = GetVehicleXenonLightsColour(vehicle),

			neonEnabled       = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},

			neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras            = extras,
			tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers       = GetVehicleMod(vehicle, 0),
			modFrontBumper    = GetVehicleMod(vehicle, 1),
			modRearBumper     = GetVehicleMod(vehicle, 2),
			modSideSkirt      = GetVehicleMod(vehicle, 3),
			modExhaust        = GetVehicleMod(vehicle, 4),
			modFrame          = GetVehicleMod(vehicle, 5),
			modGrille         = GetVehicleMod(vehicle, 6),
			modHood           = GetVehicleMod(vehicle, 7),
			modFender         = GetVehicleMod(vehicle, 8),
			modRightFender    = GetVehicleMod(vehicle, 9),
			modRoof           = GetVehicleMod(vehicle, 10),

			modEngine         = GetVehicleMod(vehicle, 11),
			modBrakes         = GetVehicleMod(vehicle, 12),
			modTransmission   = GetVehicleMod(vehicle, 13),
			modHorns          = GetVehicleMod(vehicle, 14),
			modSuspension     = GetVehicleMod(vehicle, 15),
			modArmor          = GetVehicleMod(vehicle, 16),

			modTurbo          = IsToggleModOn(vehicle, 18),
			modSmokeEnabled   = IsToggleModOn(vehicle, 20),
			modXenon          = IsToggleModOn(vehicle, 22),

			modFrontWheels    = GetVehicleMod(vehicle, 23),
			modBackWheels     = GetVehicleMod(vehicle, 24),

			modPlateHolder    = GetVehicleMod(vehicle, 25),
			modVanityPlate    = GetVehicleMod(vehicle, 26),
			modTrimA          = GetVehicleMod(vehicle, 27),
			modOrnaments      = GetVehicleMod(vehicle, 28),
			modDashboard      = GetVehicleMod(vehicle, 29),
			modDial           = GetVehicleMod(vehicle, 30),
			modDoorSpeaker    = GetVehicleMod(vehicle, 31),
			modSeats          = GetVehicleMod(vehicle, 32),
			modSteeringWheel  = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate         = GetVehicleMod(vehicle, 35),
			modSpeakers       = GetVehicleMod(vehicle, 36),
			modTrunk          = GetVehicleMod(vehicle, 37),
			modHydrolic       = GetVehicleMod(vehicle, 38),
			modEngineBlock    = GetVehicleMod(vehicle, 39),
			modAirFilter      = GetVehicleMod(vehicle, 40),
			modStruts         = GetVehicleMod(vehicle, 41),
			modArchCover      = GetVehicleMod(vehicle, 42),
			modAerials        = GetVehicleMod(vehicle, 43),
			modTrimB          = GetVehicleMod(vehicle, 44),
			modTank           = GetVehicleMod(vehicle, 45),
			modWindows        = GetVehicleMod(vehicle, 46),
			modLivery         = GetVehicleLivery(vehicle)
		}
	else
		return
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Trim
-----------------------------------------------------------------------------------------------------------------------------------------


Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Round
-----------------------------------------------------------------------------------------------------------------------------------------

Round = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end
    
RegisterNetEvent("qb-rewards:client:CreatePlayerVeh")
AddEventHandler("qb-rewards:client:CreatePlayerVeh", function(vehicle_model, plate)
	local x,y,z,h = 0,0,0,0
	SpawnVehicle(vehicle_model, { x = x, y = y, z = z }, h, function(vehicle)		
		local vehicleProps = GetVehicleProperties(vehicle)
		vehicleProps.plate = plate
		SetVehicleNumberPlateText(vehicle, plate)
        print("Se trimite")
		TriggerServerEvent('qb-rewards:server:InsertVehIntoGarage', vehicleProps, vehicle_model)
	end)
end)


RegisterNUICallback('action', function(data, cb)
    if data.action == 'CloseUI' then
        rewards = {}    
        SetNuiFocus(false,false)
        ui = false
    end

    if data.action == 'AddReward' then
        local newReward = {}
        if data.rewardType == 'vehicle' then
            newReward = {
                id = data.id,
                rewardType = data.rewardType,
                name = data.name,
                model = data.model
            
            }
            rewards[#rewards+1] = newReward
        elseif data.rewardType == 'money' then
            newReward = {
                id = data.id,
                rewardType = data.rewardType,
                amount = data.amount
            }
            rewards[#rewards+1] = newReward
        elseif data.rewardType == 'item' then
            newReward = {
                id = data.id,
                rewardType = data.rewardType,
                label = data.label,
                amount = data.amount,
                name = data.name
            }
            rewards[#rewards+1] = newReward
        end
        UpdateRewards()
    end

    if data.action == "SearchVehicles" then
        print("Searched")

        local vehicles = findVehicles(data.text)
        SendNUIMessage({
            type = "displayVehicles",
            vehicleList = vehicles
        })
    end

    if data.action == "SearchItems" then
        print("Searched")

        local itemList = findItems(data.text)
        print("Sending items")
        SendNUIMessage({
            type = "displayItems",
            itemList = itemList
        })
        print("sent")
    end
    if data.action == "GenerateCode" then
        TriggerServerEvent("qb-rewards:server:AddCodeToDB", rewards)
    end
end)

RegisterNetEvent("qb-rewards:client:CopyCode")
AddEventHandler("qb-rewards:client:CopyCode", function(code)
	print("Copying to clipboard")
	SendNUIMessage({
		type = "CopyToClipboard",
		string = string.format(""..code.."")
	})
end)

RegisterNetEvent("qb-rewards:client:requestCode")
AddEventHandler("qb-rewards:client:requestCode", function(code)
    SendNUIMessage({
        type = "GetCode",
    })
end)

RegisterNetEvent("qb-rewards:client:OpenUI")
AddEventHandler("qb-rewards:client:OpenUI", function()
    OpenUI()
end)