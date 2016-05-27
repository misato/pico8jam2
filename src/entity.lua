-- Entity class
-- Player and Enemy will inherit from this one

Entity = {}
Entity.__index = Entity

function Entity.create()
    local entity = {}

    setmetatable(entity, Entity)

    entity.x = 60
    entity.y = 60
    entity.frames = 0

    entity.position = POSITION_DOWN

    return entity
end

function Entity:update()
    self:update_frames()
    self:update_coords()
end

function Entity:update_frames()
    local frame = self.frames
    frame += 0.2
    if flr(frame) == 3 then 
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

