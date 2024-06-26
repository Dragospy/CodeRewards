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

RegisterCommand('Rewards', function()
    if not ui then
        SendNUIMessage({
            type = "ShowUI"
        })
        SetNuiFocus(true,true)
        ui = true   
    end
end, false)


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
end)

function UpdateRewards()
    SendNUIMessage({
        type = "UpdateRewards",
        rewards = rewards
    })
end

RegisterKeyMapping('Rewards', 'Opens/Closes UI', 'keyboard', 'L')