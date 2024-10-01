--[[
To create a terminal in LÖVE 2D that reads certain words as input and processes them, you'll need to implement a text input system and a way to parse the input for specific commands or keywords.

Here’s a basic outline of how to do this:

1. Set Up Input Capture:
Use LÖVE’s love.textinput to capture typed characters and love.keypressed for handling special keys (like Enter or Backspace).

2. Store User Input:
Create a string that stores the characters the user types.

3. Process the Input:
Once the user presses Enter, process the input to check for specific words or commands.

4. Respond to Commands:
Use conditional statements to check if the input matches the command you expect and then execute the corresponding logic.

Here’s an example:
--]]
-- Terminal state
local terminalInput = ""
local terminalActive = false -- To activate/deactivate the terminal
local commandList = {"start", "stop", "reset", "status"} -- Commands you want to accept
local lastCommand = ""

-- Capture typed text
function love.textinput(t)
    if terminalActive then
        terminalInput = terminalInput .. t
    end
end

-- Handle special keys (e.g., Enter, Backspace)
function love.keypressed(key)
    if terminalActive then
        if key == "return" then
            -- Process the command
            processCommand(terminalInput)
            terminalInput = "" -- Clear input after processing
        elseif key == "backspace" then
            -- Remove the last character
            terminalInput = terminalInput:sub(1, -2)
        elseif key == "escape" then
            terminalActive = false -- Exit terminal mode
        end
    elseif key == "t" then
        terminalActive = true -- Activate terminal on "t" key press
    end
end

-- Process terminal commands
function processCommand(input)
    -- Trim any extra spaces
    local trimmedInput = input:match("^%s*(.-)%s*$")
    
    -- Check if the input matches any command
    for _, command in ipairs(commandList) do
        if trimmedInput == command then
            lastCommand = "Executed command: " .. command
            return
        end
    end
    
    -- If no command matches
    lastCommand = "Unknown command: " .. trimmedInput
end

-- Draw the terminal and input
function love.draw()
    if terminalActive then
        love.graphics.print("> " .. terminalInput, 10, 10)
    end
    
    if lastCommand ~= "" then
        love.graphics.print(lastCommand, 10, 30)
    end
end
--[[
Key Elements:
terminalInput: Stores the user's input as they type.
love.textinput: Captures characters and appends them to terminalInput.
love.keypressed: Handles special keys, including Enter (to submit the command) and Backspace (to delete characters).
processCommand: Processes the input and compares it to a list of valid commands. You can expand this to include more complex behaviors.
Rendering: The terminal interface is simple, just a text string drawn at the top of the screen.
Additional Enhancements:
You can add a history buffer to show previous commands.
You could allow command parameters, like start level1 or status all, by splitting the input into words using string.match or string.gmatch.
Customize the terminal window appearance (e.g., borders, colors, text highlighting).
--]]

--[[
Another snippets I got to help make consoles
--]]

local root=(...):match("(.-)[^%/%.]+$")
local colors=require(root .. 'colors')
local console={}
console.config={
    name=nil,                       -- Name of the console. unused.
    extend=false,                   -- Extend love.graphics with console.
    buffer_width=80,                -- Amount of columns.
    buffer_height=50,               -- Amount of rows.
    font=nil,                       -- Console font.
    font_size=16,                   -- Size of the font characters.
    background_color=colors.black,  -- Color of the background.
    foreground_color=colors.white   -- Color of the characters.
}
function console:initialize(props)
    if props ~= nil then
        for name, value in pairs(props) do
            self.config[name] = value
        end
    end 
    if self.config.font then
        love.graphics.setFont(love.graphics.newFont(self.config.font, self.config.font_size))
    end
    if self.config.extend then 
        love.graphics.console = self
    end
    love.window.setMode(self.config.buffer_width * self.config.font_size, 
                        self.config.buffer_height * self.config.font_size)
end
function console:print(line, col, row, text_color, background_color)
    love.graphics.setColor(background_color or self.config.background_color)
    love.graphics.rectangle("fill", 
        col * self.config.font_size, 
        row * self.config.font_size, 
        #line * self.config.font_size, 
        1 * self.config.font_size)
    love.graphics.setColor(self.config.foreground_color) 
    love.graphics.print({text_color or self.config.foreground_color, line}, 
    col * self.config.font_size, 
    row * self.config.font_size) 
end
function console:fill()
    for x = 0, self.config.buffer_width-1 do 
        for y = 0, self.config.buffer_height-1 do 
            self:print(string.char(love.math.random(65, 89)), x, y, colors.random(), colors.random())
        end
    end
end
return console