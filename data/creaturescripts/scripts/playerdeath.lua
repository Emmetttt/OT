function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")
	if (player:getCondition(CONDITION_HASFLAG, CONDITIONID_DEFAULT)) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have the flag mate.")
		player:removeCondition(CONDITION_HASFLAG, CONDITIONID_DEFAULT)
		
		local corpsePos = corpse:getPosition()
		local pos = {
			x = corpsePos.x,
			y = corpsePos.y,
			z = corpsePos.z,
			stackpos = 1
		}

		if (player:getCondition(CONDITION_WHITETEAM, CONDITIONID_DEFAULT)) then
			Game.createItem(5617, 1, pos)
		elseif (player:getCondition(CONDITION_BLACKTEAM, CONDITIONID_DEFAULT)) then
			Game.createItem(1436, 1, pos)
		end
	end
end