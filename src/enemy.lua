-- Enemy

ENEMY_TYPE_1 = 1
ENEMY_TYPE_2 = 2
ENEMY_TYPE_3 = 3
ENEMY_TYPE_4 = 4

-- child = setmetatable({},{__index=parent})

Enemy = {}
Enemy.__index = Entity

function Enemy.create(enemy_type, position)
	local new_enemy = {}

	setmetatable(new_enemy, Enemy)

    new_enemy.frames = 0

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

	new_enemy.position = position
	if position == POSITION_DOWN then 
		new_enemy.x = 60
		new_enemy.y = 0
	elseif position == POSITION_UP then 
		new_enemy.x = 60
		new_enemy.y = 120
	elseif position == POSITION_LEFT then 
		new_enemy.x = 120
		new_enemy.y = 60
	elseif position == POSITION_RIGHT then 
		new_enemy.x = 0
		new_enemy.y = 60
	end

	return new_enemy
end

-- function Enemy:update()
-- 	self:update_frames()
-- 	self:update_coords()
-- end

-- function Enemy:update_frames()
--     local frame = self.frames
--     frame += 0.1
--     if flr(frame) == 3 then 
--         frame = 0
--     end
--     self.frames = frame
-- end

-- function Enemy:update_coords() 
--     -- there is a wall around the room. wall is 1 tile width
--     local WALL_SIZE = 8
    
--     if self.position == POSITION_DOWN then
--         if (self.y + 1)  < (SCREEN_SIZE - WALL_SIZE) then
--             self.y += 1
--         else 
--         	self:move()
--         end

--     elseif self.position == POSITION_UP then
--         if (self.y - 1) > WALL_SIZE then
--             self.y -= 1
--         else 
--         	self:move()
--         end

--     elseif self.position == POSITION_RIGHT then
--         if (self.x + 1) < (SCREEN_SIZE - WALL_SIZE) then
--             self.x += 1
--         else 
--         	self:move()
--         end

--     elseif self.position == POSITION_LEFT then
--         if (self.x - 1) > WALL_SIZE then
--             self.x -= 1
--         else 
--         	self:move()
--         end
--     end

-- end



-- function Enemy:draw()
-- 	local enemy_frame = flr(self.frames)
--     local mirror = false -- used to mirror the sprite for the left position
--     local position = self.position 
--     --  if the enemy position is left, then we want the right sprite but mirrored
--     if position == POSITION_LEFT then
--         position = POSITION_RIGHT
--         mirror = true
--     end
--     local sprite = self.sprite[position] + enemy_frame
--     spr(sprite,self.x, self.y, 1, 1, mirror, false)
-- end


-- function Enemy.create(position, enemy_type)
-- 	local new_enemy = Entity.init(position, 2, 0.1)
-- 	new_enemy.type = enemy_type

-- 	if enemy_type == ENEMY_TYPE_1 then
-- 		new_enemy.sprite = {80,82,84}
-- 	elseif enemy_type == ENEMY_TYPE_2 then
-- 		new_enemy.sprite = {86,88,90}
-- 	elseif enemy_type == ENEMY_TYPE_3 then
-- 		new_enemy.sprite = {99,101,103}
-- 	elseif enemy_type == ENEMY_TYPE_4 then
-- 		new_enemy.sprite = {105,107,109}
-- 	end

-- 	return new_enemy
-- end

function Enemy:update()
	self:update_frames()
	local has_moved = self:update_coords()
	if not has_moved then
		self:move()
	end
end

function Enemy:move()
	-- update enemy position
    new_position = flr(rnd(4)) + 1
    self.position = new_position
end

-- Enemies array and util functions

enemy_list = {}

function spawn_enemy(position) 
	-- Create new enemy
	local enemy_type = flr(rnd(4)) + 1
	new_enemy = Enemy.create(position, enemy_type)
	add(enemy_list, new_enemy)
end

function enemies_update() 
	for monster in all(enemy_list) do
		monster:update()
	end
end

function enemies_draw()
	for monster in all(enemy_list) do
		monster:draw()
	end
end
