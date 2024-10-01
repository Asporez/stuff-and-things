local fuelCell1 = {
    powerOutput = 10,       -- Power in megawatts (MW)
    maxPower = 10,          -- Maximum power capacity of the fuel cell (10 MW)
    fuelAmount = 100,       -- Total fuel in kilograms
    fuelRate = 0.1,         -- Fuel consumption rate per second (in kg/s)
    temperature = 300,      -- Operating temperature in Kelvin
    maxTemperature = 1000,  -- Maximum allowable temperature in Kelvin
    temperatureRate = 5,    -- Rate at which temperature increases per second
    running = false,        -- Whether the fuel cell is running
}

local fuelCell2 = {
    powerOutput = 8,        -- Power in megawatts (MW)
    maxPower = 8,           -- Maximum power capacity
    fuelAmount = 80,        -- Total fuel in kilograms
    fuelRate = 0.08,        -- Fuel consumption rate per second
    temperature = 300,      -- Operating temperature in Kelvin
    maxTemperature = 900,   -- Maximum allowable temperature in Kelvin
    temperatureRate = 4,    -- Rate at which temperature increases per second
    running = false,        -- Whether the fuel cell is running
}

-- Cooling system
local coolingSystem = {
    active = false,         -- Whether the cooling system is running
    coolingRate = 10,       -- Cooling rate in Kelvin per second
}
-- Update function to simulate fuel cell operations and cooling system
function love.update(dt)
    -- Update fuel cell 1 if it's running
    if fuelCell1.running and fuelCell1.fuelAmount > 0 then
        fuelCell1.fuelAmount = fuelCell1.fuelAmount - (fuelCell1.fuelRate * fuelCell1.powerOutput * dt)
        fuelCell1.temperature = fuelCell1.temperature + (fuelCell1.temperatureRate * dt)

        if fuelCell1.temperature > fuelCell1.maxTemperature then
            fuelCell1.powerOutput = fuelCell1.powerOutput - 0.5 -- Reduce power if overheating
        end

        if fuelCell1.fuelAmount <= 0 then
            fuelCell1.fuelAmount = 0
            fuelCell1.powerOutput = 0
        end
    end

    -- Update fuel cell 2 if it's running
    if fuelCell2.running and fuelCell2.fuelAmount > 0 then
        fuelCell2.fuelAmount = fuelCell2.fuelAmount - (fuelCell2.fuelRate * fuelCell2.powerOutput * dt)
        fuelCell2.temperature = fuelCell2.temperature + (fuelCell2.temperatureRate * dt)

        if fuelCell2.temperature > fuelCell2.maxTemperature then
            fuelCell2.powerOutput = fuelCell2.powerOutput - 0.5 -- Reduce power if overheating
        end

        if fuelCell2.fuelAmount <= 0 then
            fuelCell2.fuelAmount = 0
            fuelCell2.powerOutput = 0
        end
    end

    -- Cooling system effect
    if coolingSystem.active then
        -- Reduce temperature of fuel cells while cooling system is active
        fuelCell1.temperature = fuelCell1.temperature - (coolingSystem.coolingRate * dt)
        fuelCell2.temperature = fuelCell2.temperature - (coolingSystem.coolingRate * dt)

        -- Ensure temperatures don't go below a minimum threshold (e.g., 300 K)
        fuelCell1.temperature = math.max(300, fuelCell1.temperature)
        fuelCell2.temperature = math.max(300, fuelCell2.temperature)
    end
end

-- Draw function to display terminal and fuel cells
function love.draw()
    love.graphics.clear(0, 0, 0) -- Black background

    -- Display terminal input and output
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("> " .. terminalInput, 50, 50)
    love.graphics.print(terminalOutput, 50, 80)

    -- Display fuel cell 1 status
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("Fuel Cell 1 Power Output: " .. string.format("%.2f", fuelCell1.powerOutput) .. " MW", 50, 150)
    love.graphics.print("Fuel Cell 1 Remaining Fuel: " .. string.format("%.2f", fuelCell1.fuelAmount) .. " kg", 50, 180)
    love.graphics.print("Fuel Cell 1 Temperature: " .. string.format("%.2f", fuelCell1.temperature) .. " K", 50, 210)

    -- Display fuel cell 2 status
    love.graphics.setColor(0, 0, 1)
    love.graphics.print("Fuel Cell 2 Power Output: " .. string.format("%.2f", fuelCell2.powerOutput) .. " MW", 50, 250)
    love.graphics.print("Fuel Cell 2 Remaining Fuel: " .. string.format("%.2f", fuelCell2.fuelAmount) .. " kg", 50, 280)
    love.graphics.print("Fuel Cell 2 Temperature: " .. string.format("%.2f", fuelCell2.temperature) .. " K", 50, 310)

    -- Display cooling system status
    love.graphics.setColor(1, 1, 1)
    if coolingSystem.active then
        love.graphics.print("Cooling System: ACTIVE", 50, 350)
    else
        love.graphics.print("Cooling System: INACTIVE", 50, 350)
    end
end
