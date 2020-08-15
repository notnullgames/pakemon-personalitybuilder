local anim8 = require "lib.anim8"
local lurker = require "lib.lurker.lurker"

local mood = 1
local speed = 0.5

-- setup: outside of load() so lurker weill pick it up
local image = love.graphics.newImage("test.png")
image:setFilter('nearest', 'nearest')
local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())

local animations = {
    { "happy", anim8.newAnimation(g('1-6', 1), speed) },
    { "excited", anim8.newAnimation(g('1-6', 2), speed) },
    { "curious", anim8.newAnimation(g('1-6', 3), speed) },
    { "lazy",  anim8.newAnimation(g('1-6', 4), speed) },
    { "sleepy",  anim8.newAnimation(g('1-6', 5), speed) },
    { "sad",  anim8.newAnimation(g('1-6', 6), speed) }
}

function love.update(dt)
    animations[mood][2]:update(dt)
    -- hot-reloading
    lurker.update()
end

function love.draw()    
    love.graphics.setBackgroundColor( 0.6, 0.5, 0.4, 1 )
    -- display buttons
    love.graphics.setColor(1, 1, 1, 0.8)
    for i, dmood in pairs(animations) do
        if mood == i then
            love.graphics.print("•", 720, i*20)
        end
        love.graphics.print(dmood[1], 730, i*20)
    end
    love.graphics.scale(20,20)
    animations[mood][2]:draw(image, x, y)
end

function love.keypressed(key, code)
    if key == 'up' then
        updateMood(-1)
    end

    if key == 'down' then
        updateMood(1)
    end
end


-- set the mood to a new value
function updateMood(amount)
    mood = mood + amount
    if mood > #animations then
        mood = 1
    elseif mood < 1 then
        mood = #animations
    end
end
