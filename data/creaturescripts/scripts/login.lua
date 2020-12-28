local vocationEquipment = 
{
	[5] = { -- sorcerer
		Head		= 2491, -- crown helmet
		Necklace	= nil,
		Backpack	= 10518,
		Armor		= 2656, -- blue robe
		Right		= 2520, -- demon shield
		Left		= 8922, -- wand of voodoo
		Legs		= 7730, -- blue legs
		Feet		= 2643, -- leather boots
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2293, Count = 50 }  -- mwall
		}
	},
	[6] = { -- druid
		Head		= 2491, -- crown helmet
		Necklace	= nil,
		Backpack	= 10521,
		Armor		= 2656, -- blue robe
		Right		= 2520, -- demon shield
		Left		= 8911, -- northwind rod
		Legs		= 7730, -- blue legs
		Feet		= 2195, -- BOH
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 2274, Count = 100 }, -- ava
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2316, Count = 100 }, -- healing wind
			{ Id = 2293, Count = 50 }, -- mwall
			{ Id = 2269, Count = 50 }, -- tree wall
			{ Id = 2278, Count = 20 }  -- para
		}
	},
	[7] = { -- paladin
		Head		= 2493, -- demon helmet
		Necklace	= nil,
		Backpack	= 3940,
		Armor		= 2656, -- blue robe
		Right		= nil,
		Left		= 2455, -- xbow
		Legs		= 2488, -- crown legs
		Feet		= 2643, -- leather boots
		Ring		= nil,
		Ammo		= 18436, -- drill bolt
		Items		= {
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 8472, Count = 100 },  -- gsp
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 2295, Count = 100 }, -- holy missile
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2293, Count = 50 }    -- mwall
		}
	},
	[8] = { -- knight
		Head		= 2493, -- demon helmet
		Necklace	= nil,
		Backpack	= 9774,
		Armor		= 2492, -- dsm
		Right		= nil,
		Left		= 6553, -- ruthless axe
		Legs		= 2470, -- golden legs
		Feet		= 2643, -- leather boots
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 2514, Count = 1 }, -- mms
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 2293, Count = 50 }  -- mwall
		}
	},
}
local slots = {CONST_SLOT_FIRST, CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_BACKPACK, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO}

function onLogin(player)
	-- Stamina
	nextUseStaminaTime[player.uid] = 0
	equipStarterEquipment(player)
	resetToDefaultLevel(player)

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")

	return true
end

function resetToDefaultLevel(player)
	local mageDefaultHealth = 1145
	local paladinDefaultHealth = 2105
	local knightDefaultHealth = 3000
	local mageDefaultMana = 5850
	local paladinDefaultMana = 2970
	local knightDefaultMana = 1050

	local vocation =  player:getVocation():getId()
	-- set stats back to default
	if vocation == 8 then -- knight
		player:setMaxHealth(knightDefaultHealth)
		player:setMaxMana(knightDefaultMana)
		player:addHealth(knightDefaultHealth)
		player:addMana(knightDefaultMana)
	elseif vocation == 5 or vocation == 6 then -- mage
		player:setMaxHealth(mageDefaultHealth)
		player:setMaxMana(mageDefaultMana)
		player:addHealth(mageDefaultHealth)
		player:addMana(mageDefaultMana)
	elseif vocation == 7 then -- paladin
		player:setMaxHealth(paladinDefaultHealth)
		player:setMaxMana(paladinDefaultMana)
		player:addHealth(paladinDefaultHealth)
		player:addMana(paladinDefaultMana)
	else
		player:setMaxHealth(2)
	end

	player:setLevel(200)
end

function equipStarterEquipment(player)
	for i = 1, #slots do
		local item = player:getSlotItem(slots[i])
		if item then
			item:remove(1)
		end
	end

	local vocation = player:getVocation():getId()
	equip(player, vocationEquipment[vocation].Head, CONST_SLOT_HEAD, 1)
	equip(player, vocationEquipment[vocation].Necklace, CONST_SLOT_NECKLACE, 1)
	equip(player, vocationEquipment[vocation].Backpack, CONST_SLOT_BACKPACK, 1)
	equip(player, vocationEquipment[vocation].Armor, CONST_SLOT_ARMOR, 1)
	equip(player, vocationEquipment[vocation].Right, CONST_SLOT_RIGHT, 1)
	equip(player, vocationEquipment[vocation].Left, CONST_SLOT_LEFT, 1)
	equip(player, vocationEquipment[vocation].Feet, CONST_SLOT_FEET, 1)
	equip(player, vocationEquipment[vocation].Ring, CONST_SLOT_RING, 1)
	equip(player, vocationEquipment[vocation].Ammo, CONST_SLOT_AMMO, 100)
	equip(player, vocationEquipment[vocation].Legs, CONST_SLOT_LEGS, 1)
	equipItems(player, vocationEquipment[vocation].Items)
end

function equip(player, item, location, count)
	if item == nil then
		return true
	end

	player:addItemEx(Game.createItem(item, count), false, location)
	return true
end

function equipItems(player, items)
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	for i = 1, #items do
		backpack:addItem(items[i].Id, items[i].Count)
	end
end
