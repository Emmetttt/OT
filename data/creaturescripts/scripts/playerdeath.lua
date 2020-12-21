local vocationEquipment = 
{
	[5] = { -- sorcerer
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[3]	= { Id = 18390, Slot = CONST_SLOT_LEFT }, -- Wand of Defiance
		[4]	= { Id = 13760, Slot = CONST_SLOT_LEFT } -- Wand of Dimensions
	},
	[6] = { -- druid
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[3]	= { Id = 8910, Slot = CONST_SLOT_LEFT}, -- Underworld Rod
		[4]	= { Id = 25888, Slot = CONST_SLOT_LEFT } -- Rod of Mayhem
	},
	[7] = { -- paladin
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[3]	= { Id = 8850, Slot = CONST_SLOT_LEFT}, -- Chain Bolter
		[4]	= { Id = 18453, Slot = CONST_SLOT_LEFT } -- Crystal Crossbow
	},
	[8] = { -- knight
		[1]	= { Id = 2195, Slot = CONST_SLOT_FEET }, -- BOH
		[2]	= { Id = 2206, Slot = CONST_SLOT_RING }, -- Time Ring
		[3]	= { Id = 8926, Slot = CONST_SLOT_LEFT}, -- Demonwing
		[4]	= { Id = 2408, Slot = CONST_SLOT_LEFT} -- Warlord Sword
	},
}
local slots = {CONST_SLOT_FIRST, CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_BACKPACK, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO}
local baseExpGain = 15000000

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")
	
	incrementSet(killer)
	addExp(killer, player:getStreak())
	if (killer:getGuid() ~= mostDamageKiller:getGuid()) then
		incrementSet(mostDamageKiller)
		addExp(mostDamageKiller, player:getStreak())
	end

	for i = 1, #slots do
		local item = player:getSlotItem(slots[i])
		if item then
			item:remove(1)
		end
	end

	equipStarterEquipment(player)
end

function addExp(player, streak)
	if (player == nil or streak == 0) then
		return true
	end
	player:addExperience(baseExpGain * streak * math.random(0.5, 1.5))

	return true
end

function incrementSet(player)
	if (player == nil or player:getVocation() == nil) then
		return true
	end
	
	local vocation = player:getVocation():getId()
	local config = vocationEquipment[vocation][player:getStreak()]
	local item = player:getSlotItem(config.Slot)
	if item then
		item:remove(1)
	end
	player:addItemEx(Game.createItem(config.Id, 1), false, config.Slot)
end