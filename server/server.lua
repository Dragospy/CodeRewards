local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-rewards:server:AddCodeToDB")
AddEventHandler("qb-rewards:server:AddCodeToDB", function(rewards)
    local src = source
    local code = math.random(1000000000, 9999999999)
    local result = exports.oxmysql:executeSync('SELECT * FROM rewards WHERE code=@input', {
        ['@input'] = code,
    })
    if result[1] then
        TriggerEvent('qb-rewards:server:AddCodeToDB', rewards)
    else
        TriggerClientEvent('qb-rewards:client:CopyCode', src, code)
        exports.oxmysql:execute("INSERT INTO rewards(code, rewards) VALUES ('"..code.."', '"..json.encode(rewards).."')")
    end
end)

RegisterNetEvent('qb-rewards:server:InsertVehIntoGarage', function(vehicleProps, vehicle_model)
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    print("S-a incercat")
	local query = 'INSERT INTO player_vehicles (citizenid ,license ,hash ,plate, vehicle, mods, state, garage) VALUES (@citizenid,@license,@hash,@plate, @vehicle, @mods, @state, @garage )'
	local var = {
		['@citizenid']   = xPlayer.PlayerData.citizenid,
		['@license'] = QBCore.Functions.GetIdentifier(source,'license'),
		['@hash'] = tostring(GetHashKey(vehicle_model)),
		['@plate']   = vehicleProps.plate,
		['@vehicle']   = vehicle_model,
		['@state']   = 1,
		['@mods'] = json.encode(vehicleProps),
		['@garage']   = 'haanparking'
	}
	exports.oxmysql:execute(query,var)
end)

RegisterCommand(Config.OpenCommand, function(source)
    local src = source
    if QBCore.Functions.HasPermission(src, "god")  or QBCore.Functions.HasPermission(src, "co-god") or QBCore.Functions.HasPermission(src, "dev") or QBCore.Functions.HasPermission(src, "manager") or QBCore.Functions.HasPermission(src, "managerstaff") or QBCore.Functions.HasPermission(src, "sadmin")or QBCore.Functions.HasPermission(src, "admin") or QBCore.Functions.HasPermission(src, "moderator") or QBCore.Functions.HasPermission(src, "helper") or QBCore.Functions.HasPermission(src, "helpert") then
        TriggerClientEvent('qb-rewards:client:OpenUI', source)
    else 
        TriggerClientEvent('QBCore:Notify', source, "You don't have access", 'error')
    end
end, false)

RegisterCommand(Config.ClaimCommand, function(source, code)
    local license = QBCore.Functions.GetIdentifier(source, "license")
    local result = exports.oxmysql:executeSync('SELECT * FROM rewards WHERE code=@input', {
        ['@input'] = code,
    })
    if result[1] then
        print(json.decode(result[1].rewards))
        local Player = QBCore.Functions.GetPlayer(source)
        local rewards = json.decode(result[1].rewards)
        for k, v in pairs(rewards) do
            if v.rewardType == 'item' then
                if Player.Functions.AddItem(v.name, v.amount, false) then
                    TriggerClientEvent('QBCore:Notify', source, "You've been given "..v.label.."", 'success') 
                end
            elseif v.rewardType == 'money' then
                if Player then
                    Player.Functions.AddMoney("bank", v.amount)
                end
                TriggerClientEvent('QBCore:Notify', source, "You've been given "..v.amount.."$", 'success') 
            elseif v.rewardType == 'vehicle' then
                GivePlayerVeh(source, v)
            end
        end
        exports.oxmysql:execute('DELETE FROM rewards WHERE code=@input', {
            ['@input'] = code,
        })
    else
        TriggerClientEvent('QBCore:Notify', source, "Invalid Code", 'error') 
    end
end, false)

function GivePlayerVeh(src, veh)
    local plate = GeneratePlate()
    TriggerClientEvent('qb-rewards:client:CreatePlayerVeh', src, veh.model, plate)
    TriggerClientEvent('QBCore:Notify', src, "You've been given "..veh.name.." with the number plate: "..plate, 'success')
end

function GeneratePlate()
    local plateFormat = 'nnn lll'
    local generatedPlate = ''
    math.randomseed(os.time())
	for i = 1, math.min(#plateFormat, 8) do
		local currentChar = string.sub(plateFormat, i, i)
		if currentChar == 'n' then
			local a = math.random(0, 9)
			generatedPlate = generatedPlate .. a
		elseif currentChar == 'l' then
			local a = string.char(math.random(65, 90))
			generatedPlate = generatedPlate .. a
		elseif currentChar == 'x' then
			local isLetter = math.random(0, 1)
			if isLetter == 1 then
				local a = string.char(math.random(65, 90))
				generatedPlate = generatedPlate .. a
			else
				local a = math.random(0, 9)
				generatedPlate = generatedPlate .. a
			end
		else
			generatedPlate = generatedPlate ..  string.upper(currentChar)
		end
	end
    local isDuplicate = exports.oxmysql:executeSync('SELECT COUNT(1) FROM player_vehicles WHERE plate = @plate', {
		['@plate'] = generatedPlate
    })
    if isDuplicate == 1 then
		generatedPlate = GeneratePlate()
    end
    return generatedPlate
end
