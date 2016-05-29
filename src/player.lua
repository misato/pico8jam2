-- Player

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
        player.position = POSITION_LEFT
    -- right
    elseif btn(1) then
        player.position = POSITION_RIGHT
    -- up
    elseif btn(2) then
        player.position = POSITION_UP
    -- down
    elseif btn(3) then
        player.position = POSITION_DOWN 
    else
        is_moving = false 
    end

    if btn(4) or btn(5) then
        -- shoot
       shoot_lightning()
    end

    return is_moving
end

function shoot_lightning()
    -- calculate new coordinates for the bolt
    sfx(2)
    local new_x, new_y = calculate_sprite_movement(player.x, player.y, 1, player.position)
    add_lightning(new_x, new_y, player.position)
end


function update_player_coords() 
    local new_x, new_y = calculate_sprite_movement(player.x, player.y, 1, player.position)
    player.x = new_x
    player.y = new_y

end

player = {}
player.x = 60
player.y = 60
player.frames = 0
player.health = 5
player.inmune = true
player.inmune_frames = 0
player.position = POSITION_DOWN
player.sprite = { 64, 67, 70 } -- depending on the position
player.update = function()
    if player.health > 0 then
        if handle_player_input() then
            update_player_frames()
            update_player_coords()
        else
            player.frames = 1 -- idle position
        end 

        if not player.inmune and is_enemy_in_coords(player.x, player.y) then
            sfx(1)
            player.health -= 1
            player.inmune = true
            player.inmune_frames = 0
        end
    else
        change_state()
    end
end

function draw_player_sprite()
    -- we want the animation to be "bouncing". ie 64, 65, 66 and 65 again
    local player_frame = flr(player.frames)
    if player_frame == 3 then
        player_frame = 1
    end
    local mirror = false -- used to mirror the sprite for the left position
    local position = player.position 
    --  if the player position is left, then we want the right sprite but mirrored
    if position == POSITION_LEFT then
        position = POSITION_RIGHT
        mirror = true
    end
    local sprite = player.sprite[position] + player_frame
    spr(sprite,player.x, player.y, 1, 1, mirror, false)
end

player.draw = function()
    
    if player.inmune then
        player.inmune_frames += 1
        if mod(player.inmune_frames, 3) == 0 then
            draw_player_sprite()
        end
        if player.inmune_frames > 20 then
            player.inmune = false
            player.inmune_frames = 0
        end
    else
        draw_player_sprite()
    end
end

