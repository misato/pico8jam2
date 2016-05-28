-- Global 

SCREEN_SIZE = 120 -- same width than height so no need for 2 vars ;) 
WALL_SIZE = 8 -- there is a wall around the room. wall is 1 tile width

-- defined here so it's easier to work with positions later
POSITION_DOWN = 1
POSITION_UP = 2
POSITION_RIGHT = 3
POSITION_LEFT = 4

wave = 0
stage = 0
score = 0

function calculate_sprite_movement(x,y,speed,position)
    local new_y = y
    local new_x = x

    if position == POSITION_DOWN then
        if (new_y + speed)  < (SCREEN_SIZE - WALL_SIZE) then
            new_y += speed
        end

    elseif position == POSITION_UP then
        if (new_y - speed) > WALL_SIZE then
            new_y -= speed
        end

    elseif position == POSITION_RIGHT then
        if (new_x + speed) < (SCREEN_SIZE - WALL_SIZE) then
            new_x += speed
        end 
    elseif position == POSITION_LEFT then
        if (new_x - speed) > WALL_SIZE then
            new_x -= speed
        end
    end

    return new_x, new_y
end

include src/player.lua
include src/enemy.lua
include src/lightning.lua

-- state machine 

-- game states
-- there are no enum in lua so followed the advice from here: https://www.allegro.cc/forums/thread/605178
game_states = {
    splash = 0,
    game = 1, 
    gameover = 2
}

state = game_states.splash

function change_state() 
    cls()
    if state == game_states.splash then 
        -- change from splash to game
        -- spawn some enemies
        state = game_states.game
    elseif state == game_states.game then
        state = game_states.gameover 
    elseif state == game_states.gameover then
        state = game_states.splash
    end
end

-- pico8 game funtions

function _init()
    cls()
    palt(0,false); palt(14,true)
    -- music(0)
end

function _update()
    if state == game_states.splash then   
        update_splash()
    elseif state == game_states.game then
        update_game() 
    elseif state == game_states.gameover then
        update_gameover()
    end
end

function _draw()
    if state == game_states.splash then   
        draw_splash()
    elseif state == game_states.game then
        draw_game()
    elseif state == game_states.gameover then
        draw_gameover()
    end
end


-- splash

function update_splash()
    if btn(4) or btn(5) then
        change_state()
    end
end

function draw_splash() 
   write_centered_text("press any button")
end


-- game

function update_game()
    player.update()
    bolts_update()
    enemies_update()
end

function draw_game()
    map(0,0)
    write_score()
    player.draw()
    bolts_draw()
    enemies_draw()
end


-- game over

function update_gameover()
    if btn(4) or btn(5) then
        change_state()
    end
end

function draw_gameover()
    write_centered_text("GAME OVER")
end

-- utils

-- writes a text centered in the screen
-- watch out! it's not taking in account multiple lines!
function write_centered_text(text)
    
    local SPRITE_WIDTH = 4
    local SPRITE_HEIGHT = 8

    local x = (SCREEN_SIZE - #text * SPRITE_WIDTH) / 2
    local y = (SCREEN_SIZE - SPRITE_HEIGHT) / 2  

    print(text, x, y)
end

function mod(a,b)
   return a - flr(a/b)*b
end

function write_score()
    print(score,2,2,0)
end

