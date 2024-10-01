Here's an updated version of the `shipSystems.lua` with a list of predefined systems for each `systemType` (engine, shields, weapons, and sensors), each providing different modifiers. This will give you a variety of systems to install, and each will provide unique bonuses. The terminology has been updated to use "systems" instead of "modules."

### `src/shipSystems.lua`
```lua
local shipSystems = {}

shipSystems.__index = shipSystems

-- Predefined systems for each system type with different modifiers
shipSystems.availableSystems = {
    engine = {
        { name = "Standard Engine", thrustBonus = 10 },
        { name = "High-Speed Engine", thrustBonus = 20 },
        { name = "Economy Engine", thrustBonus = 5 },
        { name = "Overdrive Engine", thrustBonus = 30 }
    },
    shields = {
        { name = "Basic Shield", shieldBonus = 50 },
        { name = "Advanced Shield", shieldBonus = 100 },
        { name = "Reflective Shield", shieldBonus = 75 },
        { name = "Adaptive Shield", shieldBonus = 120 }
    },
    weapons = {
        { name = "Laser Cannon", weaponBonus = 25 },
        { name = "Plasma Gun", weaponBonus = 50 },
        { name = "Missile Launcher", weaponBonus = 40 },
        { name = "Ion Blaster", weaponBonus = 60 }
    },
    sensors = {
        { name = "Basic Sensors", sensorBonus = 10 },
        { name = "Long-Range Sensors", sensorBonus = 20 },
        { name = "Advanced Targeting", sensorBonus = 30 },
        { name = "Stealth Detection", sensorBonus = 25 }
    }
}

function shipSystems.new()
    local self = setmetatable({}, shipSystems)

    -- Define slots for systems: engine, shields, weapons, sensors
    self.slots = {
        engine = nil,    -- Engine system slot
        shields = nil,   -- Shield system slot
        weapons = nil,   -- Weapons system slot
        sensors = nil    -- Sensors system slot
    }

    -- Base stats that can be modified by installed systems
    self.baseThrust = 10
    self.currentThrust = self.baseThrust
    self.shieldStrength = 0
    self.weaponPower = 0
    self.sensorRange = 0

    return self
end

-- Install a system into a slot
function shipSystems:installSystem(systemType, systemIndex)
    if self.slots[systemType] and shipSystems.availableSystems[systemType] then
        local system = shipSystems.availableSystems[systemType][systemIndex]

        if system then
            print("Installing " .. system.name .. " into " .. systemType .. " slot.")
            self.slots[systemType] = system

            -- Apply the system's effects on the ship
            self:applySystemEffects(systemType)
        else
            print("Invalid system index for " .. systemType .. ".")
        end
    else
        print("Invalid system type.")
    end
end

-- Remove a system from a slot
function shipSystems:removeSystem(systemType)
    if self.slots[systemType] then
        print("Removing " .. systemType .. " system.")
        self.slots[systemType] = nil

        -- Revert to base stats
        self:resetSystemEffects(systemType)
    end
end

-- Apply the effects of the installed system to the ship
function shipSystems:applySystemEffects(systemType)
    local system = self.slots[systemType]

    if system then
        if systemType == "engine" then
            self.currentThrust = self.baseThrust + system.thrustBonus
        elseif systemType == "shields" then
            self.shieldStrength = system.shieldBonus
        elseif systemType == "weapons" then
            self.weaponPower = system.weaponBonus
        elseif systemType == "sensors" then
            self.sensorRange = system.sensorBonus
        end
    end
end

-- Reset stats when a system is removed
function shipSystems:resetSystemEffects(systemType)
    if systemType == "engine" then
        self.currentThrust = self.baseThrust
    elseif systemType == "shields" then
        self.shieldStrength = 0
    elseif systemType == "weapons" then
        self.weaponPower = 0
    elseif systemType == "sensors" then
        self.sensorRange = 0
    end
end

-- Function to get the current thrust value
function shipSystems:getThrust()
    return self.currentThrust
end

return shipSystems
```

### How to integrate with `playerShip.lua`

You can integrate this updated `shipSystems` logic into your `playerShip` class as follows:

1. Use the `shipSystems:installSystem(systemType, systemIndex)` function to install a system by passing the system type and the corresponding index of the system you want to install.
2. In `playerShip:movement`, the thrust will be dynamically adjusted based on the installed engine system.

Here's the modified `playerShip.lua`:

```lua
local love = require('love')
local playerShip = {}

local keyMapping = require('src.keyMapping')
local shipSystems = require('src.shipSystems')

playerShip.__index = playerShip

function playerShip.new()
    local self = setmetatable({}, playerShip)
    self.x = 100
    self.y = 100
    self.sprite = love.graphics.newImage('data/sprites/ship1.png')
    self.spriteWidth = self.sprite:getWidth()
    self.spriteHeight = self.sprite:getHeight()
    self.angle = 0
    self.velocityX = 0
    self.velocityY = 0
    self.hull = 100
    self.power = 100

    -- Initialize ship systems
    self.systems = shipSystems.new()

    -- Install an initial engine system
    self.systems:installSystem("engine", 1)  -- Installing "Standard Engine" as default

    return self
end

function playerShip:applyCrewBonus(crewMembers)
    for _, crew in ipairs(crewMembers) do
        crew:onDuty(self)  -- Pass the ship object to the crew member to apply their bonus
    end
end

function playerShip:movement(dt)
    local turnSpeed = 5
    if love.keyboard.isDown(keyMapping.keyRight) then
        self.angle = self.angle + turnSpeed * dt
    end

    if love.keyboard.isDown(keyMapping.keyLeft) then
        self.angle = self.angle - turnSpeed * dt
    end

    if love.keyboard.isDown(keyMapping.keyUp) then
        local thrust = self.systems:getThrust() -- Get thrust from the shipSystems module
        self.velocityX = self.velocityX + math.cos(self.angle - math.pi / 2) * thrust * dt
        self.velocityY = self.velocityY + math.sin(self.angle - math.pi / 2) * thrust * dt
    end
end

function playerShip:draw()
    love.graphics.push()
    love.graphics.translate(self.x + self.spriteWidth / 2, self.y + self.spriteHeight / 2)
    love.graphics.rotate(self.angle)
    love.graphics.draw(self.sprite, -self.spriteWidth / 2, -self.spriteHeight / 2)
    love.graphics.pop()
end

return playerShip
```

### Explanation:
- **Systems List**: For each `systemType` (engine, shields, weapons, sensors), we now have a list of 4 different systems, each providing different modifiers (e.g., different levels of thrust or shield bonuses).
- **Installation**: Use `shipSystems:installSystem(systemType, systemIndex)` to install a system into the corresponding slot. You can extend this by letting the player choose or unlock systems during gameplay.
- **Dynamic Modification**: The ship's attributes like `thrust`, `shieldStrength`, and `weaponPower` are dynamically adjusted based on the installed systems.

You can now easily swap different systems during gameplay to modify the ship's performance in real-time. This structure also keeps the logic clean and modular.