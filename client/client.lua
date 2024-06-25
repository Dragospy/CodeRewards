local ui = false

RegisterCommand('Rewards', function()
    if not ui then
        SendNUIMessage({
            type = "ShowUI"
        })
        SetNuiFocus(true,true)
        ui = true   
    end
end, false)

RegisterNUICallback('CloseUI', function(data, cb)
    SetNuiFocus(false,false)
    ui = false
end)

RegisterKeyMapping('Rewards', 'Opens/Closes UI', 'keyboard', 'L')