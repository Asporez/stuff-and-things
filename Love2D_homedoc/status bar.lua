-- Variables for the fuel cell status (0% to 100%)
local fuelCellPercentage = 0  -- Starts at 0%, can be dynamically updated

-- Constants for the bar dimensions and position
local barWidth = 200
local barHeight = 30
local barX = 50
local barY = 300

-- Function to calculate the color between red and green based on percentage
function getColorForPercentage(percentage)
    local red = 1 - (percentage / 100)  -- Red decreases as percentage increases
    local green = percentage / 100      -- Green increases as percentage increases
    return red, green, 0                -- Blue is always 0 for this gradient
end

-- Function to draw the fuel cell status bar
function drawFuelCellBar(percentage)
    -- Draw the background bar (red at 0%)
    love.graphics.setColor(1, 0, 0)  -- Red
    love.graphics.rectangle("fill", barX, barY, barWidth, barHeight)

    -- Calculate the fill width based on the percentage
    local fillWidth = (percentage / 100) * barWidth

    -- Get the color based on the current percentage
    local red, green, blue = getColorForPercentage(percentage)

    -- Draw the filled bar on top of the background
    love.graphics.setColor(red, green, blue)  -- Color based on the percentage
    love.graphics.rectangle("fill", barX, barY, fillWidth, barHeight)

    -- Draw the percentage text inside the bar
    love.graphics.setColor(1, 1, 1)  -- White text
    love.graphics.printf(string.format("%d%%", percentage), barX, barY + 5, barWidth, "center")
end

-- Update function to increment the fuel cell percentage
function love.update(dt)
    -- Increment the fuel cell percentage every second (for demo purposes)
    fuelCellPercentage = (fuelCellPercentage + dt * 20) % 101  -- Loops from 0% to 100%
end

-- Draw function
function love.draw()
    -- Draw the fuel cell status bar
    drawFuelCellBar(fuelCellPercentage)

    -- Additional elements (like terminal or other UI) can be drawn here
end
