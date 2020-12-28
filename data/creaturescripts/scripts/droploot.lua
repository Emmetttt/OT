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
	local vocation = player:getVocation():getId()
	if player:hasFlag(PlayerFlag_NotGenerateLoot) or vocation == VOCATION_NONE then
		return true
	end

	-- ALSO drop potentially one good item
	for i = 1, #config do
		if math.random(1,100) <= config[i].chance then
			corpse:addItem(config[i].itemId)
		end
	end
	return true
end
