<<<<<<< Updated upstream
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
=======
local deathListEnabled = true
local vocationEquipment = 
{
	[5] = { -- sorcerer
		RewardOne		= 2195, -- BOH
		RewardTwo		= 2206, -- Time Ring
		RewardThree		= 18390, -- Wand of Defiance
		RewardFour		= 13760 -- Wand of Dimensions
	},
	[6] = { -- druid
		RewardOne		= 2195, -- BOH
		RewardTwo		= 2206, -- Time Ring
		RewardThree		= 8910, -- Underworld Rod
		RewardFour		= 25888 -- Rod of Mayhem
	},
	[7] = { -- paladin
		RewardOne		= 2195, -- BOH
		RewardTwo		= 2206, -- Time Ring
		RewardThree		= 8850, -- Chain Bolter
		RewardFour		= 18453 -- Crystal Crossbow
	},
	[8] = { -- knight
		RewardOne		= 2195, -- BOH
		RewardTwo		= 2206, -- Time Ring
		RewardThree		= 8926, -- Demonwing
		RewardFour		= 2408 -- Warlord Sword
	},
}
local slots = {CONST_SLOT_FIRST, CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_BACKPACK, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO}

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")
	
	incrementSet(killer)
	if (killer:getGuid() ~= mostDamageKiller:getGuid()) then
		incrementSet(mostDamageKiller)
	end

	for i = 1, #slots do
		local item = player:getSlotItem(slots[i])
		player:removeItem(item, 1)
	end

	equipStarterEquipment(player)
end

function incrementSet(player)
	if (player == nil or player:getVocation() == nil or player:getSkull() == nil) then
		return true
	end
	
	local vocation = player:getVocation():getId()
	local skull = player:getSkull()

	if (skull == 1) then
		addItem(player, vocationEquipment[vocation].RewardOne)
	elseif (skull == 2) then
		addItem(player, vocationEquipment[vocation].RewardTwo)
	elseif (skull == 3) then
		addItem(player, vocationEquipment[vocation].RewardThree)
	elseif (skull == 4) then
		addItem(player, vocationEquipment[vocation].RewardFour)
	end
end

function addItem(player, id)
	
	-- for i = 1, #slots do
	-- 	local item = player:getSlotItem(slots[i])
	-- 	if (item ~= nil and id == item) then
	-- 		return true
	-- 	end
	-- end
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if (backpack ~= nil and not player:getItemById(id, true)) then-- and not backpack:hasItem(id)) then
		backpack:addItem(id, 1)
>>>>>>> Stashed changes
	end
end