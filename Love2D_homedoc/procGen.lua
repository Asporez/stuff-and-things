-- License CC0 (Creative Commons license) (c) darkfrei, 2022

function love.load()
	tileSize = 32 -- for image 32x32 pixels
	a = {image = love.graphics.newImage("air.png")} -- image 32x32 pixels
	g = {image = love.graphics.newImage("ground.png")} -- image 32x32 pixels

	local w, h = 25, 18
	map = {}
	for y = 1, h do
		map[y] = {}
		for x = 1, w do
			local value = love.math.noise( 0.08*x, 0.2*y)
			if value > 0.8 then -- 80% air and 20% ground
				map[y][x] = g -- ground
			else
				map[y][x] = a -- air
			end
		end
	end
end

function love.update(dt)

end

function love.draw()
	for y, xs in ipairs (map) do
		for x, tile in ipairs (xs) do
			love.graphics.draw(tile.image, (x-1)*tileSize, (y-1)*tileSize)
		end
	end
end