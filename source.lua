-- Global 

SCREEN_SIZE = 128 -- same width than height so no need for 2 vars ;) 

-- Player

-- defined here so it's easier to work with positions later
PLAYER_DOWN = 1
PLAYER_UP = 2
PLAYER_RIGHT = 3
PLAYER_LEFT = 4

function update_player_frames()
    -- Use local because it's faster
    local frame = player.frames
    frame += 0.2
    if flr(frame) == 4 then 
        frame = 0
    end
    player.frames = frame
end

function handle_player_input()
    
    local is_moving = true 
    -- left
    if btn(0) then
        player.position = PLAYER_LEFT
    -- right
    elseif btn(1) then
        player.position = PLAYER_RIGHT
    -- up
    elseif btn(2) then
        player.position = PLAYER_UP
    -- down
    elseif btn(3) then
        player.position = PLAYER_DOWN 
    else
        is_moving = false 
    end

    return is_moving
end

function update_player_coords() 
    if player.position == PLAYER_DOWN then
        player.y += 1
        if player.y > SCREEN_SIZE then
            player.y = 0
        end

    elseif player.position == PLAYER_UP then
        player.y -= 1
        if player.y < 0 then 
            player.y = SCREEN_SIZE
        end

    elseif player.position == PLAYER_RIGHT then
        player.x += 1
        if player.x > SCREEN_SIZE then
            player.x = 0
        end

    elseif player.position == PLAYER_LEFT then
        player.x -= 1
        if player.x < 0 then 
            player.x = SCREEN_SIZE
        end
    end
end

player = {}
player.x = 60
player.y = 0
player.frames = 0
player.position = PLAYER_DOWN
player.sprite = { 64, 67, 70 } -- depending on the position
player.update = function() 
    local is_moving = handle_player_input()
    if is_moving then
        update_player_frames()
        update_player_coords()
    else
        player.frames = 1 -- idle position
    end 
end

player.draw = function()
    -- we want the animation to be "bouncing". ie 64, 65, 66 and 65 again
    local player_frame = flr(player.frames)
    if player_frame == 3 then
        player_frame = 1
    end
    local mirror = false -- used to mirror the sprite for the left position
    local position = player.position 
    --  if the player position is left, then we want the right sprite but mirrored
    if position == PLAYER_LEFT then
        position = PLAYER_RIGHT
        mirror = true
    end
    local sprite = player.sprite[position] + player_frame
    spr(sprite,player.x, player.y, 1, 1, mirror, false)
end


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


