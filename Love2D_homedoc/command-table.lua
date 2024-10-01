local commandMap = {
    ["start.cellA"] = function(serviceModule) 
        serviceModule.fuelCell1.running = true 
        terminal.output = "Fuel Cell A Online."
    end,
    ["stop.cellA"] = function(serviceModule) 
        serviceModule.fuelCell1.running = false 
        terminal.output = "Fuel Cell A Offline."
    end,
    -- Add more commands as needed
}

function terminal.processSingleCommand(command, serviceModule)
    local commandAction = commandMap[command]
    if commandAction then
        commandAction(serviceModule)
    else
        terminal.output = "Unknown command: " .. command
    end
end
