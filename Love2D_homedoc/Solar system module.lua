-- Solar system module
local solarsystem = {}

-- Solar system objects
solarsystem.star = { x = 50000, y = 50000, radius = 1000, color = {1, 1, 0} }  -- Star at the center

-- Planet orbit data (distance from star, speed of orbit, etc.)
solarsystem.planets = {
    {
        name = "Inner Planet",
        orbitRadius = 2000,         -- Distance from star
        orbitSpeed = 0.5,           -- Orbit speed (radians per second)
        currentAngle = 0,           -- Starting angle in radians
        radius = 300,               -- Planet radius
        color = {0.8, 0.3, 0.2}     -- Color of the planet
    },
    {
        name = "Earth-like Planet",
        orbitRadius = 10000,        -- Earth-like distance
        orbitSpeed = 0.2,           -- Slower orbit
        currentAngle = 0,           -- Starting angle
        radius = 500,
        color = {0.2, 0.5, 1}
    },
    {
        name = "Gas Giant 1",
        orbitRadius = 35000,        -- Farther distance for gas giant
        orbitSpeed = 0.1,           -- Slow orbit
        currentAngle = 0,
        radius = 1000,
        color = {0.6, 0.4, 0.2}
    },
    {
        name = "Gas Giant 2",
        orbitRadius = 45000,        -- Farthest gas giant
        orbitSpeed = 0.08,          -- Very slow orbit
        currentAngle = 0,
        radius = 1200,
        color = {0.4, 0.6, 0.3}
    }
}

-- Function to update planet positions (simulate orbits)
function solarsystem.update(dt)
    for _, planet in ipairs(solarsystem.planets) do
        -- Update planet's orbit angle
        planet.currentAngle = planet.currentAngle + planet.orbitSpeed * dt
        
        -- Calculate planet's position based on its orbit radius and current angle
        planet.x = solarsystem.star.x + math.cos(planet.currentAngle) * planet.orbitRadius
        planet.y = solarsystem.star.y + math.sin(planet.currentAngle) * planet.orbitRadius
    end
end

-- Function to draw the solar system (star and planets)
function solarsystem.draw()
    -- Draw the star
    love.graphics.setColor(solarsystem.star.color)
    love.graphics.circle("fill", solarsystem.star.x, solarsystem.star.y, solarsystem.star.radius)

    -- Draw the planets
    for _, planet in ipairs(solarsystem.planets) do
        love.graphics.setColor(planet.color)
        love.graphics.circle("fill", planet.x, planet.y, planet.radius)
    end
end

return solarsystem
