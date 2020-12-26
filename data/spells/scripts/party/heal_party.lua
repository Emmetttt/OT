local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, 10 * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 200)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 500)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 500)
condition:setParameter(CONDITION_PARAM_MANAGAIN, 200)
condition:setParameter(CONDITION_PARAM_MANATICKS, 500)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

function onCastSpell(creature, variant)
	return creature:addPartyCondition(combat, variant, condition, 1600, CONST_ME_HEARTS)
end
