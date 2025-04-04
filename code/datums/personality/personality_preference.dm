/datum/preference/personality
	savefile_key = "personalities"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/personality/apply_to_human(mob/living/carbon/human/target, value)
	if(isdummy(target) || CONFIG_GET(flag/disable_human_mood) || isnull(target.mob_mood))
		return
	for(var/personality_key in value)
		var/datum/personality/personality = GLOB.personality_controller.personalities_by_key[personality_key]
		personality.apply_to_mob(target)

/datum/preference/personality/is_valid(value)
	return islist(value) || isnull(value)

/datum/preference/personality/deserialize(input, datum/preferences/preferences)
	if(!LAZYLEN(input))
		return null

	var/list/input_sanitized
	for(var/personality_key in input)
		var/datum/personality/personality = GLOB.personality_controller.personalities_by_key[personality_key]
		if(!istype(personality))
			continue
		if(GLOB.personality_controller.is_incompatible(input_sanitized, personality.type))
			continue
		if(LAZYLEN(input_sanitized) >= CONFIG_GET(number/max_personalities))
			break
		LAZYADD(input_sanitized, personality_key)

	return input_sanitized

/datum/preference/personality/create_default_value()
	return null
