local love = require 'love'

function love.load()

    images = {} -- class to handle images

    for imageIndex, image in ipairs( { -- create tuple to set the index order of images loaded
        1, 2, 3, 4, 5, 6, 7, 8,
        'uncovered', 'covered_highlighted', 'covered',
        'flower', 'flag', 'question',
    } ) do
        images[image] = love.graphics.newImage( 'images/'..image..'.png' ) -- load images and establish method to index
    end

    cellSize = 18 -- declare the size of each cells

    gridXCount = 19 -- declare the number of cells
    gridYCount = 14
    
end

function love.update()

    selectedX = math.floor( love.mouse.getX() / cellSize ) + 1 -- declare variables to detect mouse cursor over cells using the size declared in load phase
    selectedY = math.floor( love.mouse.getY() / cellSize ) + 1

    if selectedX > gridXCount then
        selectedX = gridXCount
    end

    if selectedY > gridYCount then
        selectedY = gridYCount
    end
    
end

function love.draw()
    -- draw the covered cell image on every cell
    for y = 1, gridYCount do
        for x = 1, gridXCount do
            local image
            if x == selectedX and y == selectedY then -- checks if mouse is above the cell
                if love.mouse.isDown(1) then -- checks if mouse button is pressed
                    image = images.uncovered -- draws uncovered cell when mouse button is pressed
                else
                    image = images.covered_highlighted -- draws higlighted cell if cursor is above it
                end
            else
                image = images.covered
            end
            love.graphics.draw(
                image,
                ( x - 1 ) * cellSize, ( y - 1 ) * cellSize
            )
        end
    end

    -- print the stored variables on screen
    --love.graphics.setColor( 0, 0, 0 )
    --love.graphics.print( 'selectedX: '..selectedX..'selectedY: '..selectedY )
    --love.graphics.setColor( 1, 1, 1 )

end