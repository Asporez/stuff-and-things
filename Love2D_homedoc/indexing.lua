local love = require 'love'

function love.load()
    fruits = { "apple", "pears" } -- create table called fruits and set the immutable index
    table.insert( fruits, "bananas" ) -- insert bananas to index
    table.insert( fruits, "oranges" ) -- inserting values to index
end

function love.update(dt)
    
end

function love.draw()
    
love.graphics.print( fruits[1], 100, 500 )
love.graphics.print( fruits[2], 100, 600 )
love.graphics.print( fruits[3], 100, 700 )
love.graphics.print( fruits[4], 100, 800 )
end