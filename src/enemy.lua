-- Account = {} 
-- Account.__index = Account 

-- function Account.create(balance)
-- local acnt = {} -- our new object 
-- setmetatable(acnt,Account) -- make Account handle lookup 
-- acnt.balance = balance -- initialize our object 
-- return acnt 
-- end 

-- function Account:withdraw(amount)
-- self.balance = self.balance - amount 
-- end -- create and use an Account 

-- acc = Account.create(1000)
-- acc:withdraw(100)


-- Enemy
function create_new_enemy()

	enemy = {}
	enemy.x = 0
	enemy.y = 0
	enemy.frames = 0
	enemy.position = POSITION_DOWN
	enemy.type = 1
	enemy.sprite = {}
	enemy.update = function() 
	    update_enemy_frames()
	    update_enemy_coords()
	end

	function update_enemy_frames()
	    -- Use local because it's faster
	    local frame = enemy.frames
	    frame += 0.1
	    if flr(frame) == 3 then 
	        frame = 0
	    end
	    enemy.frames = frame
	end

	function update_enemy_coords() 
	    -- there is a wall around the room. wall is 1 tile width
	    local WALL_SIZE = 8
	    
	    if enemy.position == POSITION_DOWN then
	        if (enemy.y + 1)  < (SCREEN_SIZE - WALL_SIZE) then
	            enemy.y += 1
	        else 
	        	move_enemy()
	        end

	    elseif enemy.position == POSITION_UP then
	        if (enemy.y - 1) > WALL_SIZE then
	            enemy.y -= 1
	        else 
	        	move_enemy()
	        end

	    elseif enemy.position == POSITION_RIGHT then
	        if (enemy.x + 1) < (SCREEN_SIZE - WALL_SIZE) then
	            enemy.x += 1
	        else 
	        	move_enemy()
	        end

	    elseif enemy.position == POSITION_LEFT then
	        if (enemy.x - 1) > WALL_SIZE then
	            enemy.x -= 1
	        else 
	        	move_enemy()
	        end
	    end

	end

	function move_enemy()
		-- update enemy position
	    new_position = flr(rnd(4)) + 1
	    enemy.position = new_position
	end


	enemy.draw = function()
		local enemy_frame = flr(enemy.frames)
	    local mirror = false -- used to mirror the sprite for the left position
	    local position = enemy.position 
	    --  if the enemy position is left, then we want the right sprite but mirrored
	    if position == POSITION_LEFT then
	        position = POSITION_RIGHT
	        mirror = true
	    end
	    local sprite = enemy.sprite[position] + enemy_frame
	    spr(sprite,enemy.x, enemy.y, 1, 1, mirror, false)
	end

	return enemy

end

-- Enemies array and util functions

enemy_list = {}

function spawn_enemy(position) 
	-- Enemy types
	local ENEMY_TYPE_1 = 1
	local ENEMY_TYPE_2 = 2
	local ENEMY_TYPE_3 = 3
	local ENEMY_TYPE_4 = 4

	-- Create new enemy
	local enemy_type = flr(rnd(4)) + 1
	local new_enemy = create_new_enemy()
	new_enemy.type = enemy_type
	if enemy_type == ENEMY_TYPE_1 then
		new_enemy.sprite = {80,82,84}
	elseif enemy_type == ENEMY_TYPE_2 then
		new_enemy.sprite = {86,88,90}
	elseif enemy_type == ENEMY_TYPE_3 then
		new_enemy.sprite = {99,101,103}
	elseif enemy_type == ENEMY_TYPE_4 then
		new_enemy.sprite = {105,107,109}
	end
	
	-- random spawn point
	local enemy_position = position --flr(rnd(4)) + 1
	new_enemy.position = enemy_position
	if enemy_position == POSITION_DOWN then 
		new_enemy.x = 60
		new_enemy.y = 0
	elseif enemy_position == POSITION_UP then 
		new_enemy.x = 60
		new_enemy.y = 120
	elseif enemy_position == POSITION_LEFT then 
		new_enemy.x = 120
		new_enemy.y = 60
	elseif enemy_position == POSITION_RIGHT then 
		new_enemy.x = 0
		new_enemy.y = 60
	end 

	add(enemy_list, new_enemy)
end

function enemies_update() 
	for monster in all(enemy_list) do
		monster.update()
	end
end

function enemies_draw()
	for monster in all(enemy_list) do
		monster.draw()
	end
end
