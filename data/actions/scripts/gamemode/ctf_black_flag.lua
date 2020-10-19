local flagOutfit = Condition(CONDITION_HASFLAG, CONDITIONID_DEFAULT)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if (player:getCondition(CONDITION_WHITETEAM, CONDITIONID_DEFAULT)) then-- && !player:getCondition(CONDITION_HASFLAG, CONDITIONID_COMBAT)) then
        flagOutfit:setOutfit({
            lookType = 745,
            lookAddons = 1,
            lookFeet = 114,
            lookLegs = 0,
            lookBody = 0,
            lookHead = 0
        })
        flagOutfit:setTicks(-1)
        player:addCondition(flagOutfit, true)
        item:remove()
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, player:getName() .. ' has captured the white flag!')
    end
    return true
end