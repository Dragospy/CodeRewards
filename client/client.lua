local ui = false

AddEventHandler('onResourceStart', function(resourceName) -- This restarts the script and resets all progress made within it
    if resourceName == GetCurrentResourceName() then
        Wait(50)
        SendNUIMessage({showUI = false;})
    end
end)


RegisterCommand('Rewards', function()
    ui = not ui
    if ui then 
        SendNUIMessage({showUI = true;})
    else
        SendNUIMessage({showUI = false;})
    end
end)

RegisterKeyMapping('Rewards', 'Opens/Closes UI', 'keyboard', 'L')