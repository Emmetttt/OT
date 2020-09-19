local config = {
	{chance = 30, itemId = 2195}, -- BOH
	{chance = 30, itemId = 2206}, -- Time ring
	{chance = 30, itemId = 2197}, -- SSA
	{chance = 30, itemId = 2164}, -- Might ring
	{chance = 30, itemId = 8266}, -- Kosheis ammy
	{chance = 10, itemId = 8850}, -- Chain bolter
	{chance = 1, itemId = 18453}, -- Crystal Crossbow
	{chance = 10, itemId = 18390}, -- wand of defiance
	{chance = 1, itemId = 13760}, -- wand of dimensions
	{chance = 10, itemId = 8910}, -- underworld rod
	{chance = 1, itemId = 25888}, -- rod of mayhem
	{chance = 10, itemId = 8926}, -- Demonwing
	{chance = 1, itemId = 2408}, -- Warlord sword
}

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if player:hasFlag(PlayerFlag_NotGenerateLoot) or player:getVocation():getId() == VOCATION_NONE then
		return true
	end

	local amulet = player:getSlotItem(CONST_SLOT_NECKLACE)
	local isRedOrBlack = table.contains({SKULL_RED, SKULL_BLACK}, player:getSkull())
	if amulet and amulet.itemid == ITEM_AMULETOFLOSS and not isRedOrBlack then
		local isPlayer = false
		if killer then
			if killer:isPlayer() then
				isPlayer = true
			else
				local master = killer:getMaster()
				if master and master:isPlayer() then
					isPlayer = true
				end
			end
		end

		if not isPlayer or not player:hasBlessing(6) then
			player:removeItem(ITEM_AMULETOFLOSS, 1, -1, false)
		end
	else
		for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
			local item = player:getSlotItem(i)
			local lossPercent = player:getLossPercent()
			if item then
				if isRedOrBlack or math.random(item:isContainer() and 100 or 1000) <= lossPercent then
					if (isRedOrBlack or lossPercent ~= 0) and not item:moveTo(corpse) then
						item:remove()
					end
				end
			end
		end
		-- ALSO drop potentially one good item
		for i = 1, #config do
			if math.random(1,100) <= config[i].chance then
				corpse:addItem(config[i].itemId)
			end
		end 	
	end

	if not player:getSlotItem(CONST_SLOT_BACKPACK) then
		player:addItem(ITEM_BAG, 1, false, CONST_SLOT_BACKPACK)
	end
	return true
end
