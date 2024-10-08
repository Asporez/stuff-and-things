-- https://berbasoft.com/simplegametutorials/love/asteroids/

local love = require 'love'

function love.load()

    arenaWidth = 800
    arenaHeight = 600
    
    shipRadius = 30

    bulletRadius = 5

    asteroidStages = {
        {
            speed = 120,
            radius = 15,
        },
        {
            speed = 70,
            radius = 30,
        },
        {
            speed = 50,
            radius = 50,
        },
        {
            speed = 20,
            radius = 80,
        }
    }
    function reset()
        shipX = arenaWidth / 2
        shipY = arenaHeight / 2
        shipAngle = 0
        shipSpeedX = 0
        shipSpeedY = 0

        bullets = {}
        bulletTimerLimit = 0.5
        bulletTimer = bulletTimerLimit

        asteroids = {
            {
                x = 100,
                y = 100,
            },
            {
                x = arenaWidth - 100,
                y = 100,
            },
            {
                x = arenaWidth / 2,
                y = arenaHeight - 100,
            },
        }

        for asteroidIndex, asteroid in ipairs( asteroids ) do -- gives asteroids random directional angles
            asteroid.angle = love.math.random() * ( 2 * math.pi )
            asteroid.stage = #asteroidStages
        end

    end

    reset()

end

function love.update(dt)

    local turnSpeed = 10

    if love.keyboard.isDown( 'right' ) then -- turns the ship angle to the right
        shipAngle = shipAngle + turnSpeed * dt
    end

    if love.keyboard.isDown( 'left' ) then -- turns the ship angle to the left
        shipAngle = shipAngle - turnSpeed * dt
    end
    shipAngle = shipAngle % ( 2 * math.pi ) -- wraps the ship angle within -+ 2*3.141659... for some reason

    if love.keyboard.isDown( 'up' ) then
        local shipSpeed = 100
        shipSpeedX = shipSpeedX + math.cos( shipAngle ) * shipSpeed * dt
        shipSpeedY = shipSpeedY + math.sin( shipAngle ) * shipSpeed * dt
    end

    shipX = ( shipX + shipSpeedX * dt ) % arenaWidth
    shipY = ( shipY + shipSpeedY * dt ) % arenaHeight

    local function areCirclesIntersecting(aX, aY, aRadius, bX, bY, bRadius)
        return (aX - bX)^2 + (aY - bY)^2 <= (aRadius + bRadius)^2
    end

    for bulletIndex = #bullets, 1, -1 do
        local bullet = bullets[ bulletIndex ]

        bullet.timeLeft = bullet.timeLeft - dt

        if bullet.timeLeft <= 0 then
            table.remove( bullets, bulletIndex )
        else
            local bulletSpeed = 500
            bullet.x = ( bullet.x + math.cos( bullet.angle ) * bulletSpeed * dt )
                % arenaWidth
            bullet.y = ( bullet.y + math.sin( bullet.angle ) * bulletSpeed * dt )
                % arenaHeight
        end

        for asteroidIndex = #asteroids, 1, -1 do
            local asteroid = asteroids[asteroidIndex]

            if areCirclesIntersecting(
                bullet.x, bullet.y, bulletRadius,
                asteroid.x, asteroid.y,
                asteroidStages[ asteroid.stage ].radius
            ) then
                table.remove(bullets, bulletIndex) -- remove bullets when they hit asteroids

                if asteroid.stage > 1 then
                    local angle1 = love.math.random() * ( 2 * math.pi ) -- store 2 angles and assign them random opposite directions
                    local angle2 = ( angle1 - math.pi ) % ( 2 * math.pi )

                    table.insert( asteroids, { -- create 2 asteroids and assign angles
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle1,
                        stage = asteroid.stage - 1,
                    } )
                    table.insert( asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle2,
                        stage = asteroid.stage - 1,
                    } )
                end

                table.remove(asteroids, asteroidIndex) -- remove asteroids when they are hit by bullets
                break
            end

        end

    end

    bulletTimer = bulletTimer + dt

    if love.keyboard.isDown( 's' ) then
        if bulletTimer >= bulletTimerLimit then
            bulletTimer = 0

            table.insert( bullets, {
                x = shipX + math.cos( shipAngle ) * shipRadius,
                y = shipY + math.sin( shipAngle ) * shipRadius,
                angle = shipAngle,
                timeLeft = 4,
            } )
        end
    end

    for asteroidIndex, asteroid in ipairs( asteroids ) do
        asteroid.x = ( asteroid.x + math.cos( asteroid.angle )
            * asteroidStages[ asteroid.stage ].speed * dt ) % arenaWidth
        asteroid.y = ( asteroid.y + math.sin( asteroid.angle )
            * asteroidStages[ asteroid.stage ].speed * dt ) % arenaHeight

        if areCirclesIntersecting(
            shipX, shipY, shipRadius,
            asteroid.x, asteroid.y, asteroidStages[ asteroid.stage ].radius
        ) then
            reset()
            break
        end
    end

    if #asteroids == 0 then
        reset()
    end

end

function love.draw()

    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate( x * arenaWidth, y * arenaHeight )

            love.graphics.setColor( 0, 0, 1 )
            love.graphics.circle( 'fill', shipX, shipY, shipRadius )

            local shipCircleDistance = 20
            love.graphics.setColor( 0, 1, 1 )
            love.graphics.circle(
                'fill',
                shipX + math.cos( shipAngle ) * shipCircleDistance,
                shipY + math.tan( shipAngle ) * shipCircleDistance,
                5
            ) -- string to draw a circle 20 pixels from centre based on directional angle (front marker and simple trig)

            for bulletIndex, bullet in ipairs( bullets ) do
                love.graphics.setColor( 0, 1, 0 )
                love.graphics.circle( 'fill', bullet.x, bullet.y, bulletRadius )
            end

            for asteroidIndex, asteroid in ipairs( asteroids ) do
                love.graphics.setColor( 1, 1, 0 )
                love.graphics.circle( 'fill', asteroid.x, asteroid.y, asteroidStages[ asteroid.stage ].radius )
            end

        end

    end

    -- temporary
    love.graphics.origin()
    love.graphics.setColor( 1, 1, 1 )
    love.graphics.print( table.concat( {
        'shipAngle: '..shipX,
        'shipX: '..shipX,
        'shipY: '..shipY,
        'shipSpeedX: '..shipSpeedX,
        'shipSpeedY: '..shipSpeedY,
    }, '\n' ) )
end