local m = love.math
local value = m.noise(x*self.scale, y*self.scale, self.seed)
if value < 0.35 then --water
  self[x][y] = {type="water", tile = self.tiles["water"], color = {255, 255, 255}}
elseif value < 0.45 then --sand
  self[x][y] = {type="sand", tile = self.tiles["sand"], color = {255, 255, 255}}
elseif value < 0.6 then --ground
  self[x][y] = {type="ground", tile = self.tiles["ground"], color = {255, 255, 255}}
elseif value < 0.75 then --forest
  self[x][y] = {type="forest", tile = self.tiles["forest"], color = {255, 255, 255}}
else --mountain
  self[x][y] = {type="mountain", tile = self.tiles["mountain"], color = {255, 255, 255}}
end
--[[
I'd recommend creating a two-dimensional array where generated tiles would be kept. Then, when you need to show them, you just have to loop through the part of the map you need.

love.math.noise is very ordered. All you need to do is :
-define a seed by yourself (ex : 40593) OR
-define a seed depending on os.time()

Once you have your seed, you must keep it all the time and use it to generate noise. This way, your terrain will always look ordered.

By checking the "height" of the noise, you can assign a tile type to each value. 
--]] 
