local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1497)
function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		local dir = target:getDirection() -- 0: n | 1: e | 2: s | 3: w
		local targetPos = target:getPosition()
		local mwallPos = {
			x = targetPos.x,
			y = targetPos.y,
			z = targetPos.z
		}

		-- the ai tries to mwall behind you
		if dir == 0 then
			mwallPos.y = mwallPos.y + 1
		end
		if dir == 1 then
			mwallPos.x = mwallPos.x - 1
		end
		if dir == 2 then
			mwallPos.y = mwallPos.y - 1
		end
		if dir == 3 then
			mwallPos.x = mwallPos.x + 1
		end
		local tile = getThingfromPos(mwallPos, false)
		if tile ~= 0 and not hasProperty(tile.uid, CONST_PROP_BLOCKSOLID) and not isCreature(getTopCreature(pos).uid) then
			Game.createItem(1497, 1, mwallPos)
		end
	end
	return doCombat(creature, combat, variant)
end