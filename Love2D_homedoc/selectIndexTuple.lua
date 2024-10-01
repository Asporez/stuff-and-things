

function love.load()

    images = {} -- class to handle images

    for imageIndex, image in ipairs( { -- create tuple to set the index order of images loaded
        1, 2, 3, 4, 5, 6, 7, 8,
        'uncovered', 'covered_highlighted', 'covered',
        'flower', 'flag', 'question',
    } ) do
        images[image] = love.graphics.newImage( 'images/'..image..'.png' ) -- load images and establish method to index
    end
    
end