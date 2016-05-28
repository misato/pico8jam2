-- Enemy

ENEMY_TYPE_1 = 1
ENEMY_TYPE_2 = 2
ENEMY_TYPE_3 = 3
ENEMY_TYPE_4 = 4

Enemy = {}
Enemy.__index = Enemy

function Enemy.create(position, enemy_type)
	local new_enemy = {}

	setmetatable(new_enemy, Enemy)
	
	new_enemy.x = 0
	new_enemy.y = 0
	new_enemy.sprite = {}
	new_enemy.position = 0
	new_enemy.score = 10
	new_enemy.health = 10

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
		new_enemy.x = SCREEN_SIZE/2
		new_enemy.y = 0
	elseif position == POSITION_UP then 
		new_enemy.x = SCREEN_SIZE/2
		new_enemy.y = SCREEN_SIZE
	elseif position == POSITION_LEFT then 
		new_enemy.x = SCREEN_SIZE
		new_enemy.y = SCREEN_SIZE/2
	elseif position == POSITION_RIGHT then 
		new_enemy.x = 0
		new_enemy.y = SCREEN_SIZE/2
	end


	return new_enemy
end


function Enemy:update()
	if self.health <= 0 then
		score += self.score
		destroy_enemy(self)
	else
		self:update_frames()
		self:update_coords()
	end
end

function Enemy:update_frames()
    local frame = self.frames
    frame += 0.1
    if flr(frame) == 3 then 
        frame = 0
    end
    self.frames = frame
end

function Enemy:update_coords()    

	local new_x, new_y = calculate_sprite_movement(self.x, self.y, 1, self.position)
	if new_x != self.x or new_y != self.y then
		self.x = new_x
		self.y = new_y
	else 
		self:move()
	end

end

function Enemy:move()
	-- update enemy position
    self.position = flr(rnd(4)) + 1
end

function Enemy:draw()
	local enemy_frame = flr(self.frames)
    local mirror = false -- used to mirror the sprite for the left position
    local position = self.position 
    --  if the enemy position is left, then we want the right sprite but mirrored
    if position == POSITION_LEFT then
        position = POSITION_RIGHT
        mirror = true
    end
    local sprite = self.sprite[position] + enemy_frame
    spr(sprite,self.x, self.y, 1, 1, mirror, false)
end

-- Enemies array and util functions

enemy_list = {}

function destroy_enemy(enemy)
	del(enemy_list, enemy)
end

function spawn_enemy(position) 
	local enemy_type = flr(rnd(4)) + 1
	local new_enemy =  Enemy.create(position, enemy_type)
	add(enemy_list, new_enemy)
end

function enemies_update() 
	if #enemy_list > 0 then
		for enemy in all(enemy_list) do
			enemy:update()
		end
	else
		spawn_wave(wave)
		wave += 1 
	end
end

function enemies_draw()
	if #enemy_list > 0 then
		for enemy in all(enemy_list) do
			enemy:draw()
		end
	end
end

function spawn_wave(number)
	local BASE_ENEMIES_PER_WAVE = 4
	for i=1, BASE_ENEMIES_PER_WAVE+number*2 do
		local position = flr(rnd(4))+1
		spawn_enemy(position)
	end
end

function enemy_in_coords(x,y, weapon_power)
	local tile_x = flr(x / 8)
	local tile_y = flr(y / 8)
	local collision = false
	for enemy in all(enemy_list) do
		local enemy_tile_x = flr(enemy.x / 8)
		local enemy_tile_y = flr(enemy.y / 8)
		if enemy_tile_x == tile_x and enemy_tile_y == tile_y then
			enemy.health -= weapon_power
			collision = true
			break
		end
	end
	return collision
end
