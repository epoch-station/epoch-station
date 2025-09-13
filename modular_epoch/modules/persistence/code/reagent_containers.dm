/obj/item/reagent_containers/get_save_vars()
	. = ..()
	. += NAMEOF(src, amount_per_transfer_from_this)
	. += NAMEOF(src, reagent_flags)
	var/list/cached_reagents = reagent_list
	var/list/reagents_to_save
	if(cached_reagents.len)
		for(var/datum/reagent/reagent as anything in cached_reagents)
			var/amount = floor(reagent.volume) // integers are faster than decimals for saving and loading
			if(amount)
				LAZYSET(reagents_to_save, reagent.type, amount)

	if(!compare_list(reagents_to_save, list_reagents)) // avoid redundant saving if lists match
		list_reagents = reagents_to_save
		. += NAMEOF(src, list_reagents)

	return .
