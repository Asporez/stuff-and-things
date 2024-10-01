In Lua and LÖVE 2D, there are several ways to structure object-oriented programming (OOP). Here’s a list of common OOP patterns and methods for creating tables and encapsulating functions in their own files:

### 1. **Basic Table with Functions (Module)**
   - **How it works**: A simple Lua module can be a table that holds functions and variables. These can be stored in a separate file and imported with `require`.
   - **Example**: Encapsulating a set of related functions in a table.

```lua
-- /src/my_module.lua
local myModule = {}

function myModule.sayHello()
    print("Hello from myModule!")
end

return myModule
```

   - **Usage**:
```lua
-- main.lua
local myModule = require("src.my_module")
myModule.sayHello()
```

### 2. **Metatables with OOP (Prototype-based OOP)**
   - **How it works**: Lua uses metatables to simulate classes and inheritance. You define a table as your "class" and create instances of it using `setmetatable`.
   - **Example**: Using metatables to define an object and its methods.

```lua
-- /src/my_class.lua
local MyClass = {}
MyClass.__index = MyClass

function MyClass.new(name)
    local self = setmetatable({}, MyClass)
    self.name = name
    return self
end

function MyClass:speak()
    print("Hello, my name is " .. self.name)
end

return MyClass
```

   - **Usage**:
```lua
-- main.lua
local MyClass = require("src.my_class")
local obj = MyClass.new("Alice")
obj:speak()
```

### 3. **Class-based OOP using Libraries**
   - **How it works**: Lua doesn't have built-in classes, but you can use libraries like [30log](https://github.com/Yonaba/30log) or [middleclass](https://github.com/kikito/middleclass) to implement a more traditional class-based OOP system.
   - **Example**: Using the `30log` library.

```lua
-- /src/my_class.lua
local class = require('30log')
local MyClass = class("MyClass")

function MyClass:init(name)
    self.name = name
end

function MyClass:speak()
    print("Hello, my name is " .. self.name)
end

return MyClass
```

   - **Usage**:
```lua
-- main.lua
local MyClass = require("src.my_class")
local obj = MyClass("Alice")
obj:speak()
```

### 4. **Object Factory Pattern**
   - **How it works**: This pattern involves creating functions that return new tables (objects). This can be simpler than full OOP when you don’t need inheritance.
   - **Example**: Object factory to create instances.

```lua
-- /src/crew_member.lua
local function CrewMember(name, department)
    return {
        name = name,
        department = department,
        speak = function(self)
            print("Hello, I work in the " .. self.department)
        end
    }
end

return CrewMember
```

   - **Usage**:
```lua
-- main.lua
local CrewMember = require("src.crew_member")
local crew = CrewMember("Bob", "engineering")
crew:speak()
```

### 5. **Table with Closures (Functional OOP)**
   - **How it works**: You can use closures (functions that capture local variables) to create private state for objects.
   - **Example**: Using closures for encapsulation.

```lua
-- /src/timer.lua
local function Timer()
    local time = 0
    return {
        update = function(self, dt)
            time = time + dt
        end,
        getTime = function()
            return time
        end
    }
end

return Timer
```

   - **Usage**:
```lua
-- main.lua
local Timer = require("src.timer")
local timer = Timer()
timer:update(1)
print(timer:getTime()) -- 1
```

### 6. **Inheritance with Metatables**
   - **How it works**: Using metatables, you can create "subclasses" by setting one table as the metatable for another, effectively inheriting its methods.
   - **Example**: Inheriting behavior between objects.

```lua
-- /src/animal.lua
local Animal = {}
Animal.__index = Animal

function Animal.new(name)
    local self = setmetatable({}, Animal)
    self.name = name
    return self
end

function Animal:speak()
    print("I am an animal.")
end

-- /src/dog.lua
local Dog = {}
Dog.__index = Dog
setmetatable(Dog, {__index = Animal}) -- Dog inherits from Animal

function Dog.new(name)
    local self = setmetatable(Animal.new(name), Dog)
    return self
end

function Dog:speak()
    print("Woof! My name is " .. self.name)
end

return Dog
```

   - **Usage**:
```lua
-- main.lua
local Dog = require("src.dog")
local dog = Dog.new("Rover")
dog:speak() -- Woof! My name is Rover
```

### 7. **Singletons**
   - **How it works**: You can create singleton objects by defining a table with all the necessary methods and returning the same instance every time it's required.
   - **Example**: A singleton module.

```lua
-- /src/game_manager.lua
local GameManager = {
    score = 0
}

function GameManager:addScore(points)
    self.score = self.score + points
end

return GameManager
```

   - **Usage**:
```lua
-- main.lua
local GameManager = require("src.game_manager")
GameManager:addScore(10)
print(GameManager.score) -- 10
```

### Summary of Methods:
1. **Basic Table with Functions**: Simple module with a set of functions and variables.
2. **Metatables with OOP**: Simulate class-based OOP with metatables.
3. **Class-based OOP using Libraries**: Use external libraries like 30log or middleclass for a more formal OOP structure.
4. **Object Factory Pattern**: Create objects using a factory function that returns a table.
5. **Table with Closures**: Use closures for encapsulated state within objects.
6. **Inheritance with Metatables**: Create objects that inherit behavior from other objects.
7. **Singletons**: A single instance of a module or object accessible across your game.

Let me know which one you'd like to explore further, or if you'd like a more detailed explanation of any!