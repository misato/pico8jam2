-- Global 

SCREEN_SIZE = 120 -- same width than height so no need for 2 vars ;) 
WALL_SIZE = 8 -- there is a wall around the room. wall is 1 tile width

-- defined here so it's easier to work with positions later
POSITION_DOWN = 1
POSITION_UP = 2
POSITION_RIGHT = 3
POSITION_LEFT = 4

wave = 0
score = 0

titlesin = 0
titley = 0


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


function reset_game()
    score = 0

    titlesin = 0
    titley = 0

    -- Wave info
    wave = 0
    is_spawning = false
    enemies_spawned = 0
    spawning_wave_rate = 0
    show_wave_title = false

    -- player info
    player.x = 60
    player.y = 60
    player.frames = 0
    player.health = 5
    player.position = POSITION_DOWN

    -- delete enemies
    if #enemy_list > 0 then
        for enemy in all(enemy_list) do
            destroy_enemy(enemy)
        end
    end

    -- delete lighning
    if #bolt_list > 0 then
        for bolt in all(bolt_list) do
            destroy_bolt(bolt)
        end
    end
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
        -- music(0)
        state = game_states.game
    elseif state == game_states.game then
        -- music(12)
        state = game_states.gameover 
    elseif state == game_states.gameover then
        reset_game()
        -- music(8)
        state = game_states.splash
    end
end

-- pico8 game funtions

function _init()
    cls()
    palt(0,false); palt(14,true)
    -- music(8)
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
    if btn(5) then
        change_state()
    end
end

function draw_splash()
    titley+=0.01 -- speed of jumping letters
    titlesin+=0.005 -- speed of the "camera"

    bgsinloop(224)


    -- the
    spr(192,38,16+sinjump(titley),2,2)
    spr(194,56,16+sinjump(titley+0.9),2,2)
    spr(196,74,16+sinjump(titley+0.8),2,2)
    -- loot
    spr(198,30,40+sinjump(titley+0.85),2,2)
    spr(200,48,40+sinjump(titley+0.75),2,2)
    spr(200,66,40+sinjump(titley+0.65),2,2)
    spr(192,84,40+sinjump(titley+0.55),2,2)
    -- cave
    spr(204,30,64+sinjump(titley+0.7),2,2)
    spr(202,48,64+sinjump(titley+0.6),2,2)
    spr(206,66,64+sinjump(titley+0.5),2,2)
    spr(196,84,64+sinjump(titley+0.4),2,2)


    rectfill(0,0,127,2,1)
    rectfill(0,122,127,127,1)
    rectfill(0,3,127,5,0)
    line(0,4,127,4,3)
    rectfill(0,120,127,122,0)
    line(0,121,127,121,3)
    printol("press x to start",32,96,7)
    printol("by misato & jayminer",24,118,6)
end


-- game

function update_game()
    player.update()
    bolts_update()
    enemies_update()
end

function draw_game()
    draw_game_map()
    write_score()
    draw_player_lives()
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
    titley+=0.01 -- speed of jumping letters
    titlesin+=0.005 -- speed of the "camera"

    bgsinloop(232)

    pal(2,1)
    pal(13,2)
    pal(9,8)
    pal(10,9)
    pal(7,10)
    -- game
    spr(226,12,16,2,2)
    spr(202,30,16,2,2)
    spr(228,48,16,2,2)
    spr(196,66,16,2,2)
    -- over
    spr(200,46,36,2,2)
    spr(206,64,36,2,2)
    spr(196,82,36,2,2)
    spr(230,100,36,2,2)
    pal()
    palt(0,false); palt(14,true)

    printol("you scored "..score.." points",18,96,8)
    printol("try again!",46,110,8)
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
    printol(score,1,1,7)
end

function draw_player_lives()

    local x = SCREEN_SIZE

    for i= 1,player.health do
        spr(116,x,0)
        x -= 8
    end    
end

function draw_game_map()
    local map_x = 0 
    if mod(wave+1, 5) == 0 then 
        map_x = ((wave+1)/ 5) * 16
    end
    map(map_x,0)
end

-- Title and GameOver helper functions

-- this function just returns the value
-- of sin(value) multiplied by then but
-- if the value is bigger then zero it
-- sets it to zero to get the "jumping"
-- effect
function sinjump(a)
 b=sin(a)*10
 if b>0 then b=0 end
 return b
end

-- prints text with a black outline
function printol(pstring,px,py,pcol)
 for printx=0,2 do
  for printy=0,2 do
   print(pstring,px+printx,py+printy,0)
  end
 end
 print(pstring,px+1,py+1,pcol)
end

function bgsinloop(bgspr)
 for lx=-2,17 do
  for ly=-2,17 do
    spr(bgspr,lx*16+sin(titlesin)*30,ly*16+sin(titlesin/2+0.5)*30,2,2)
  end
 end
end
