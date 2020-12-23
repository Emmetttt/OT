local vocationEquipment = 
{
	[5] = { -- sorcerer
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[3]	= { Id = 24848, Slot = CONST_SLOT_HEAD }, -- shamanic mask
		[4]	= { Id = 7894, Slot = CONST_SLOT_LEGS }, -- Magma legs
		[5]	= { Id = 18390, Slot = CONST_SLOT_LEFT }, -- Wand of Defiance
		[6]	= { Id = 7899, Slot = CONST_SLOT_ARMOR }, -- Magma coat
		[7]	= { Id = 8905, Slot = CONST_SLOT_RIGHT }, -- rainbow shield
		[8]	= { Id = 5741, Slot = CONST_SLOT_HEAD }, -- Skull helmet
		[9]	= { Id = 8890, Slot = CONST_SLOT_ARMOR }, -- Robe of the underworld
		[10]= { Id = 13760, Slot = CONST_SLOT_LEFT }, -- Wand of Dimensions
		[11]= { Id = 2504, Slot = CONST_SLOT_LEGS }, -- Dwarven Legs
		[12]= { Id = 2640, Slot = CONST_SLOT_FEET }, -- soft boots
	},
	[6] = { -- druid
		[1]	= { Id = 18528, Slot = CONST_SLOT_RING }, -- prismatic ring
		[2]	= { Id = 8910, Slot = CONST_SLOT_LEFT}, -- Underworld Rod
		[3]	= { Id = 7902, Slot = CONST_SLOT_HEAD }, -- glacial mask
		[4]	= { Id = 7896, Slot = CONST_SLOT_LEGS }, -- glacial kilt
		[5]	= { Id = 25888, Slot = CONST_SLOT_LEFT }, -- Rod of Mayhem
		[6]	= { Id = 7897, Slot = CONST_SLOT_ARMOR }, -- glacial robe
		[7]= { Id = 7892, Slot = CONST_SLOT_FEET }, -- glacial shoes
		[8]= { Id = 8918, Slot = CONST_SLOT_RIGHT }, -- spellbook of dark mysteries
		
		[9]	= { Id = 7901, Slot = CONST_SLOT_HEAD }, -- lighning headband
		[10]= { Id = 7895, Slot = CONST_SLOT_LEGS }, -- lightning legs
		[11]= { Id = 7898, Slot = CONST_SLOT_ARMOR }, -- lightning robe
		[12]= { Id = 7893, Slot = CONST_SLOT_FEET }, -- lightning shoes
	},
	[7] = { -- paladin
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 21690, Slot = CONST_SLOT_LEFT}, -- triple bolt crossbow
		[3]	= { Id = 12645, Slot = CONST_SLOT_HEAD }, -- Draken helmet
		[4]	= { Id = 9777, Slot = CONST_SLOT_LEGS }, -- Yala legs
		[5]	= { Id = 9776, Slot = CONST_SLOT_ARMOR }, -- Yala Armor

		[6]	= { Id = 8850, Slot = CONST_SLOT_LEFT }, -- Chain bolter
		[7]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[8]	= { Id = 18406, Slot = CONST_SLOT_FEET }, -- primatic boots
		[9]	= { Id = 18403, Slot = CONST_SLOT_HEAD }, -- primatic helmet
		[10]= { Id = 18405, Slot = CONST_SLOT_LEGS }, -- primatic legs
		[11]= { Id = 18404, Slot = CONST_SLOT_ARMOR }, -- primatic Armor
		
		[12]= { Id = 18453, Slot = CONST_SLOT_LEFT}, -- Crystal Crossbow
	},
	[8] = { -- knight
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2472, Slot = CONST_SLOT_ARMOR }, -- MPA
		[3]	= { Id = 2197, Slot = CONST_SLOT_IN_BACKPACK}, -- SSA
		[4]	= { Id = 2496, Slot = CONST_SLOT_HEAD}, -- Horned Helmet
		[5]	= { Id = 8926, Slot = CONST_SLOT_LEFT}, -- Demonwing Axe
		[6]	= { Id = 15412, Slot = CONST_SLOT_LEGS}, -- Ornate Legs
		[7]	= { Id = 2206, Slot = CONST_SLOT_RING},	 -- Time ring

		[8]	= { Id = 21708, Slot = CONST_SLOT_FEET}, -- vampire slippers
		[9]	= { Id = 8889, Slot = CONST_SLOT_ARMOR}, -- Skullcracker armor
		[10]= { Id = 7453, Slot = CONST_SLOT_LEFT}, -- executioner
		[11]= { Id = 24809, Slot = CONST_SLOT_HEAD}, -- dark wizard's crown
		[12]= { Id = 15409, Slot = CONST_SLOT_LEGS}, -- depth orcrae
	},
}
local slots = {CONST_SLOT_FIRST, CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_BACKPACK, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO}
local baseExpGain = 15000000

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	incrementSet(killer)
	addExp(killer, player)

	if ( (killer:isPlayer() and mostDamageKiller:isPlayer() and killer:getGuid() ~= mostDamageKiller:getGuid()) or (mostDamageKiller:isPlayer() and not mostDamageKiller:isPlayer())) then
		incrementSet(mostDamageKiller)
		addExp(mostDamageKiller, player)
	end

	if (player:isPlayer()) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")

		for i = 1, #slots do
			local item = player:getSlotItem(slots[i])
			if item then
				item:remove(1)
			end
		end

		equipStarterEquipment(player)
	end
end

function addExp(killer, player)
	if (killer == nil or player == nil or not player:isPlayer() or not killer:isPlayer()) then
		return true
	end
	killer:addExperience(baseExpGain * player:getStreak() * math.random(0.5, 1.5))

	return true
end

function incrementSet(player)
	if (player == nil or not player:isPlayer()) then
		return true
	end
	
	local vocation = player:getVocation():getId()
	local config = vocationEquipment[vocation][player:getStreak()]

	if (config == nil) then
		return true
	end

	if (config.Slot == CONST_SLOT_IN_BACKPACK) then
		local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
		if (backpack == nil) then
			return true
		end

		backpack:addItem(config.Id, 30)
		return true
	end

	local item = player:getSlotItem(config.Slot)
	if item then
		item:remove(1)
	end
	player:addItemEx(Game.createItem(config.Id, 1), false, config.Slot)
end