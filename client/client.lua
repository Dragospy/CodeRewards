local ui = false

RegisterCommand('Rewards', function()
    ui = not ui
    if ui then
        SendNUIMessage({showUI = true;})
    else
        SendNUIMessage({showUI = false;})
    end
end)

RegisterKeyMapping('Rewards', 'Opens/Closes UI', 'keyboard', 'L')