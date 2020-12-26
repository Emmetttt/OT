local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 5 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_CLUB, 50)
condition:setParameter(CONDITION_PARAM_SKILL_SWORD, 50)
condition:setParameter(CONDITION_PARAM_SKILL_AXE, 50)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 50)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

function onCastSpell(creature, variant)
	return creature:addPartyCondition(combat, variant, condition, 1600, CONST_ME_BLACKSMOKE)
end
