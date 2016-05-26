-- Entity class
-- Player and Enemy will inherit from this one

Entity = class(function(e, position, maxframes, update_speed)
        e.frames = 0
        e.maxframes = maxframes
        e.update_speed = update_speed

        e.position = position

        if position == POSITION_DOWN then 
            e.x = 60
            e.y = 0
        elseif position == POSITION_UP then 
            e.x = 60
            e.y = 120
        elseif position == POSITION_LEFT then 
            e.x = 120
            e.y = 60
        elseif position == POSITION_RIGHT then 
            e.x = 0
            e.y = 60
        end
    end)

-- function Entity.create(position, maxframes, update_speed)
--     local entity = {}
--     setmetatable(entity, Entity)

--     entity.frames = 0
--     entity.maxframes = maxframes
--     entity.update_speed = update_speed

--     entity.position = position

--     if position == POSITION_DOWN then 
--         entity.x = 60
--         entity.y = 0
--     elseif position == POSITION_UP then 
--         entity.x = 60
--         entity.y = 120
--     elseif position == POSITION_LEFT then 
--         entity.x = 120
--         entity.y = 60
--     elseif position == POSITION_RIGHT then 
--         entity.x = 0
--         entity.y = 60
--     end

--     return entity
-- end

function Entity:update()
    self:update_frames()
    self:update_coords()
end

function Entity:update_frames()
    local frame = self.frames
    frame += self.update_speed
    if flr(frame) == self.maxframes then 
        frame = 0
    end
    self.frames = frame
end

function Entity:update_coords()
    local has_moved = false

    -- there is a wall around the room. wall is 1 tile width
    local WALL_SIZE = 8
    
    if self.position == POSITION_DOWN then
        if (self.y + 1)  < (SCREEN_SIZE - WALL_SIZE) then
            self.y += 1
            has_moved = true
        end

    elseif self.position == POSITION_UP then
        if (self.y - 1) > WALL_SIZE then
            self.y -= 1
            has_moved = true
        end

    elseif self.position == POSITION_RIGHT then
        if (self.x + 1) < (SCREEN_SIZE - WALL_SIZE) then
            self.x += 1
            has_moved = true
        end

    elseif self.position == POSITION_LEFT then
        if (self.x - 1) > WALL_SIZE then
            self.x -= 1
            has_moved = true
        end
    end

    return has_moved
end

function Entity:draw()
    local entity_frame = self:get_animation_frame()
    local mirror = false -- used to mirror the sprite for the left position
    local position = self.position 
    --  if the enemy position is left, then we want the right sprite but mirrored
    if position == POSITION_LEFT then
        position = POSITION_RIGHT
        mirror = true
    end
    local sprite = self.sprite[position] + entity_frame
    spr(sprite,self.x, self.y, 1, 1, mirror, false)
end

function Entity:get_animation_frame()
    return flr(self.frames)
end

