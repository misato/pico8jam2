-- Global 

SCREEN_SIZE = 128 -- same width than height so no need for 2 vars ;) 

include player.lua

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
end

function draw_game()
    map(0,0)
    player.draw()
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


