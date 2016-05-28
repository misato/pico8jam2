Lightning = {}
Lightning.__index = Lightning

function Lightning.create(x,y,direction)
    local bolt = {}

    setmetatable(bolt,Lightning)

    bolt.x = x
    bolt.y = y
    bolt.direction = direction
    bolt.speed = 8

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
    -- printh("destroy")
    del(bolt_list,bolt)
end

function Lightning:update()
    -- printh("update")
    local has_moved = self:move()
    if not has_moved then
        destroy_bolt(self)
    end
end

function Lightning:check_collision() 

    if self.direction == POSITION_DOWN then
        if (self.y + self.speed)  < (SCREEN_SIZE - WALL_SIZE) then
            
            self.y += self.speed
            can_move = true
        end

    elseif self.direction == POSITION_UP then
        if (self.y - self.speed) > WALL_SIZE then
            self.y -= self.speed
            can_move = true
        end

    elseif self.direction == POSITION_RIGHT then
        if (self.x + self.speed) < (SCREEN_SIZE - WALL_SIZE) then
            self.x += self.speed
            can_move = true
        end

    elseif self.direction == POSITION_LEFT then
        if (self.x - self.speed) > WALL_SIZE then
            self.x -= self.speed
            can_move = true
        end
    end

end

function Lightning:move()
    -- printh("move")

    local has_moved = false
    if self.direction == POSITION_DOWN then
        if (self.y + self.speed)  < (SCREEN_SIZE - WALL_SIZE) then
            self.y += self.speed
            has_moved = true
        end

    elseif self.direction == POSITION_UP then
        if (self.y - self.speed) > WALL_SIZE then
            self.y -= self.speed
            has_moved = true
        end

    elseif self.direction == POSITION_RIGHT then
        if (self.x + self.speed) < (SCREEN_SIZE - WALL_SIZE) then
            self.x += self.speed
            has_moved = true
        end

    elseif self.direction == POSITION_LEFT then
        if (self.x - self.speed) > WALL_SIZE then
            self.x -= self.speed
            has_moved = true
        end
    end

    return has_moved
end

function Lightning:draw()
    spr(self.sprite, self.x, self.y)
end

bolt_list = {}

function add_lightning(x,y,direction)
    -- printh("create with x: "..x.." y: "..y.." direction: "..direction)
    local bolt = Lightning.create(x,y,direction)
    add(bolt_list, bolt)
end

function bolts_update()
    -- printh("update")
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

