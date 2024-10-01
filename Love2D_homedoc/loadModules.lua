-- Load modules
local spaceship = require("spaceship")
local terminal = require("terminal")
local fuelcell = require("fuelcell")

-- Game state variables
local spaceshipX, spaceshipY = 300, 300  -- Starting position of spaceship

-- Load function
function love.load()
    -- Load spaceship image
    spaceship.load()

    -- Initialize terminal and fuel cells
    terminal.load()
    fuelcell.load()
end

-- Update function
function love.update(dt)
    -- Update spaceship movement
    spaceship.update(dt)

    -- Update fuel cell system (e.g., generation, consumption)
    fuelcell.update(dt)

    -- Handle terminal input
    terminal.update(dt)
end

-- Draw function
function love.draw()
    -- Draw the spaceship
    spaceship.draw()

    -- Draw the terminal
    terminal.draw()

    -- Draw the fuel cell system (status bar, etc.)
    fuelcell.draw()
end

-- Capture keypresses for the terminal
function love.textinput(text)
    terminal.textinput(text)
end

-- Capture special keys (Enter for terminal)
function love.keypressed(key)
    terminal.keypressed(key)
end

-- terminal logic

-- Import the terminal logic from earlier

local terminal = {}

-- All terminal-related variables and logic go here, as defined earlier.
-- For example:
local terminalInput = ""
local terminalOutput = ""
local commandHistory = {}

function terminal.load()
    -- Any initial setup for the terminal
end

function terminal.update(dt)
    -- Terminal logic to handle user input, command execution, etc.
end

function terminal.draw()
    -- Terminal rendering logic (text, history, etc.)
end

function terminal.textinput(text)
    -- Capture input for terminal commands
    terminalInput = terminalInput .. text
end

function terminal.keypressed(key)
    if key == "return" then
        -- Process the terminal command
        -- Add to history, clear input, etc.
    end
end

return terminal

-- fuel cell logic

-- Fuel Cell module
local fuelcell = {}

local fuelCellPercentage = 100  -- Initially full (100%)
local fuelGenerationRate = 10   -- MW generation
local fuelConsumptionRate = 5   -- Consumption rate

-- Variables for the rectangular indicator
local barWidth = 200
local barHeight = 30
local barX = 50
local barY = 300

function fuelcell.load()
    -- Initialize anything related to the fuel cell system
end

function fuelcell.update(dt)
    -- Simulate fuel cell activity: generation and consumption
    fuelCellPercentage = math.max(fuelCellPercentage - dt * fuelConsumptionRate, 0)
end

function fuelcell.draw()
    -- Draw the fuel cell status bar
    love.graphics.setColor(1, 0, 0)  -- Red
    love.graphics.rectangle("fill", barX, barY, barWidth, barHeight)

    local fillWidth = (fuelCellPercentage / 100) * barWidth
    love.graphics.setColor(0, 1, 0)  -- Green
    love.graphics.rectangle("fill", barX, barY, fillWidth, barHeight)

    -- Draw the percentage
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(string.format("%d%%", fuelCellPercentage), barX, barY + 5, barWidth, "center")
end

return fuelcell

-- spaceship logic

-- Spaceship module
local spaceship = {}

-- Spaceship variables
local spaceshipImage
local spaceshipX, spaceshipY = 300, 300  -- Initial position
local speed = 200

-- Load spaceship assets
function spaceship.load()
    spaceshipImage = love.graphics.newImage("spaceship.png")  -- Make sure to include a spaceship.png in your directory
end

-- Update spaceship position based on player input
function spaceship.update(dt)
    if love.keyboard.isDown("up") then
        spaceshipY = spaceshipY - speed * dt
    end
    if love.keyboard.isDown("down") then
        spaceshipY = spaceshipY + speed * dt
    end
    if love.keyboard.isDown("left") then
        spaceshipX = spaceshipX - speed * dt
    end
    if love.keyboard.isDown("right") then
        spaceshipX = spaceshipX + speed * dt
    end
end

-- Draw the spaceship
function spaceship.draw()
    love.graphics.draw(spaceshipImage, spaceshipX, spaceshipY, 0, 0.5, 0.5)  -- Scale the spaceship image
end

return spaceship
