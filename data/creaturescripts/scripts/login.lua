function onLogin(player)
	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	
	return true
end
