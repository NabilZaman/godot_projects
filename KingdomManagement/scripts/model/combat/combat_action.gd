class_name CombatAction
extends Resource

var battle: Battle
var source: CombatUnit
var ability: CombatAbility
var target: CombatUnit
 

# Returns an array of 3 elements:
# each element is a dictionary of units to null
# the first is the set of only harmed units, the second is the set of only helped units,
# the third is the set of units both harmed and helped
func find_impacted_units() -> Array:
	var harmed_units := {}
	var helped_units := {}
	var both_units := {}
	for effect in ability.effects:
		for unit in effect.effect_range.find_effected_units(battle, source, target):
			if effect.is_harmful():
				harmed_units[unit] = null
			elif effect.is_helpful():
				helped_units[unit] = null
	for unit in harmed_units.keys() + helped_units.keys():
		if unit in helped_units:
			harmed_units.erase(unit)
			helped_units.erase(unit)
			both_units[unit] = null
	return [harmed_units, helped_units, both_units]

func find_harmed_units() -> Array[CombatUnit]:
	var harmed_units := {}
	for effect in ability.effects:
		if effect.is_harmful():
			for unit in effect.effect_range.find_effected_units(battle, source, target):
				harmed_units[unit] = null
	return harmed_units.keys()

func find_helped_units() -> Array[CombatUnit]:
	var helped_units := {}
	for effect in ability.effects:
		if effect.is_helpful():
			for unit in effect.effect_range.find_effected_units(battle, source, target):
				helped_units[unit] = null
	return helped_units.keys()

func can_harm() -> bool:
	for effect in ability.effects:
		if effect.is_harmful():
			return true
	return false

func can_help() -> bool:
	for effect in ability.effects:
		if effect.is_helpful():
			return true
	return false

func execute() -> void:
	ability.apply(battle, source, target)
	# remove energy cost from source
	# apply counter-attack if necessary

func _init(battle: Battle, source: CombatUnit = null, ability: CombatAbility = null, target: CombatUnit = null) -> void:
	self.battle = battle
	self.source = source
	self.ability = ability
	self.target = target
