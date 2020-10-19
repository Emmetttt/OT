local flagOutfit = Condition(CONDITION_HASFLAG, CONDITIONID_DEFAULT)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if (player:getCondition(CONDITION_BLACKTEAM, CONDITIONID_DEFAULT)) then
        flagOutfit:setOutfit({
            lookType = 745,
            lookAddons = 1,
            lookFeet = 0,
            lookLegs = 114,
            lookBody = 114,
            lookHead = 114
        })
        flagOutfit:setTicks(-1)
        player:addCondition(flagOutfit)
        item:remove()
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, player:getName() .. ' has captured the white flag!')
    end
    return true
end