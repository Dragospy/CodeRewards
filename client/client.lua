local ui = false

RegisterCommand('Rewards', function()
    ui = not ui
    if ui then
        SendNUIMessage({showUI = true;})
    else
        SendNUIMessage({showUI = false;})
    end
end, false)

RegisterKeyMapping('Rewards', 'Opens/Closes UI', 'keyboard', 'L')