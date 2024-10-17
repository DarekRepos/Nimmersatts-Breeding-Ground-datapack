local config = {
    -- Entrance
    { position = { x = 33187, y = 31190, z = 7 }, destination = { x = 33216, y = 31125, z = 14 } },
    -- Exit
    { position = { x = 33216, y = 31126, z = 14 }, destination = { x = 33187, y = 31191, z = 7 } }
}

local function createMoveEvent(config)
    local moveEvent = MoveEvent()

    function moveEvent.onStepIn(creature, item, position, fromPosition)
        local player = creature:getPlayer()
        if not player then
            return false
        end

        -- Example level check (if needed)
        -- Uncomment and modify the following block if a level check is required
        -- if player:getLevel() < 200 then
        --     player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 200 to enter.")
        --     player:teleportTo(fromPosition, true)
        --     fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        --     return false
        -- end

        local currentPosition = player:getPosition()
        for _, entry in ipairs(config) do
            if Position(entry.position) == currentPosition then
                local destination = Position(entry.destination)
                player:teleportTo(destination)
                destination:sendMagicEffect(CONST_ME_TELEPORT)
                return true
            end
        end

        return false
    end

    moveEvent:type("stepin")

    for _, entry in ipairs(config) do
        moveEvent:position(Position(entry.position))
    end

    moveEvent:register()
end

-- Create and register the move event with combined config
createMoveEvent(config)
