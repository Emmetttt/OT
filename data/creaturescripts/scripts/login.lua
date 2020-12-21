local vocationEquipment = 
{
	[5] = { -- sorcerer
		Head		= 2493,
		Necklace	= nil,
		Backpack	= 10518,
		Armor		= 2494,
		Right		= 2520,
		Left		= 18409,
		Legs		= 2495,
		Feet		= 9933,
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2262, Count = 20 }, -- ebomb
			{ Id = 2293, Count = 50 }  -- mwall
		}
	},
	[6] = { -- druid
		Head		= 2662,
		Necklace	= nil,
		Backpack	= 10521,
		Armor		= 2656,
		Right		= 2542,
		Left		= 8911,
		Legs		= 7730,
		Feet		= 6132,
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 7590, Count = 100 }, -- gmp
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2268, Count = 100 }, -- SD
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2262, Count = 20 }, -- ebomb
			{ Id = 2293, Count = 50 }, -- mwall
			{ Id = 2269, Count = 50 }, -- tree wall
			{ Id = 2278, Count = 20 }  -- para
		}
	},
	[7] = { -- paladin
		Head		= 2506,
		Necklace	= nil,
		Backpack	= 3940,
		Armor		= 2505,
		Right		= nil,
		Left		= 21690,
		Legs		= 2469,
		Feet		= 11118,
		Ring		= nil,
		Ammo		= 18436,
		Items		= {
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 7589, Count = 100 },  -- smp
			{ Id = 8472, Count = 100 },  -- gsp
			{ Id = 8472, Count = 100 },  -- gsp
			{ Id = 8472, Count = 100 },  -- gsp
			{ Id = 8472, Count = 100 },  -- gsp
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 18436, Count = 100 }, -- ammo
			{ Id = 2273, Count = 100 },  -- uh
			{ Id = 2262, Count = 20 },   -- ebomb
			{ Id = 2293, Count = 50 }    -- mwall
		}
	},
	[8] = { -- knight
		Head		= 2471,
		Necklace	= nil,
		Backpack	= 9774,
		Armor		= 2466,
		Right		= nil,
		Left		= 8931,
		Legs		= 2470,
		Feet		= 2646,
		Ring		= nil,
		Ammo		= nil,
		Items		= {
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 8473, Count = 100 }, -- UHP
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 7620, Count = 100 }, -- mana potion
			{ Id = 2262, Count = 20 }, -- ebomb
			{ Id = 2293, Count = 50 }  -- mwall
		}
	},
}

function onLogin(player)
	-- Stamina
	nextUseStaminaTime[player.uid] = 0
	equipStarterEquipment(player)

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")

	return true
end

function equipStarterEquipment(player)
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