Lightning = {}
Lightning.__index = Lightning

function Lightning.create(x,y,direction)
    local bolt = {}

    setmetatable(bolt,Lightning)

    bolt.x = x
    bolt.y = y
    bolt.direction = direction
    bolt.speed = 8
    bolt.power = 1

    -- 119,120,121
    -- 125,126,127
    local sprite_rand = flr(rnd(3))
    if direction == POSITION_DOWN or direction == POSITION_UP then
        bolt.sprite = sprite_rand + 119
    else
        bolt.sprite = sprite_rand + 125
    end

    return bolt
end

function destroy_bolt(bolt)
    del(bolt_list,bolt)
end

function Lightning:update()
    local has_moved = self:move()
    if not has_moved then
        destroy_bolt(self)
    end
end

function Lightning:split()
    if self.direction == POSITION_DOWN then
        add_lightning(self.x, self.y + self.speed, POSITION_LEFT)
        add_lightning(self.x, self.y + self.speed, POSITION_RIGHT)
    elseif self.direction == POSITION_UP then
        add_lightning(self.x, self.y - self.speed, POSITION_LEFT)
        add_lightning(self.x, self.y - self.speed, POSITION_RIGHT)
    elseif self.direction == POSITION_LEFT then
        add_lightning(self.x - self.speed, self.y, POSITION_UP)
        add_lightning(self.x - self.speed, self.y, POSITION_DOWN)
    elseif self.direction == POSITION_RIGHT then
        add_lightning(self.x + self.speed, self.y, POSITION_UP)
        add_lightning(self.x + self.speed, self.y, POSITION_DOWN)
    end
end

function Lightning:move()
    local has_moved = false

    if self.direction == POSITION_DOWN then
        if (self.y + self.speed)  < (SCREEN_SIZE - WALL_SIZE) then
            local collision = weapon_collides_with_enemy(self.x, self.y + self.speed, self.power)
            if collision then 
                self:split()
            else
                self.y += self.speed
                has_moved = true
            end
        end

    elseif self.direction == POSITION_UP then
        if (self.y - self.speed) > WALL_SIZE then
            local collision = weapon_collides_with_enemy(self.x, self.y - self.speed,self.power)
            if collision then 
                self:split()
            else
                self.y -= self.speed
                has_moved = true
            end
        end

    elseif self.direction == POSITION_RIGHT then
        if (self.x + self.speed) < (SCREEN_SIZE - WALL_SIZE) then
            local collision = weapon_collides_with_enemy(self.x + self.speed, self.y, self.power)
            if collision then 
                self:split()
            else
                self.x += self.speed
                has_moved = true
            end
        end

    elseif self.direction == POSITION_LEFT then
        if (self.x - self.speed) > WALL_SIZE then
            local collision = weapon_collides_with_enemy(self.x + self.speed, self.y, self.power)
            if collision then 
                self:split()
            else
                self.x -= self.speed
                has_moved = true
            end
        end
    end

    return has_moved
end

function Lightning:draw()
    spr(self.sprite, self.x, self.y, 1, 1, self.position == POSITION_RIGHT, self.position == POSITION_DOWN)
end

bolt_list = {}

function add_lightning(x,y,direction)
    local bolt = Lightning.create(x,y,direction)
    add(bolt_list, bolt)
end

function bolts_update()
    if #bolt_list > 0 then
        for bolt in all(bolt_list) do
            bolt:update()
        end
    end 
end

function bolts_draw()
    -- printh("draw")
    if #bolt_list > 0 then
        for bolt in all(bolt_list) do
            bolt:draw()
        end
    end
end

