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
	var mixed_units := {}
	var effected_units := {}
	for effect in ability.effects:
		for unit in effect.effect_range.find_effected_units(battle, source, target):
			if effect.is_harmful():
				print("effect is harmful " + ability.name())
				harmed_units[unit] = null
			if effect.is_helpful():
				print("effect is helpful " + ability.name())
				helped_units[unit] = null
			effected_units[unit] = null
	for unit in effected_units:
		if unit in harmed_units and unit in helped_units:
			print("Unit in both!")
			harmed_units.erase(unit)
			helped_units.erase(unit)
			mixed_units[unit] = null
	return [harmed_units, helped_units, mixed_units]

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

func is_valid_target(target_pos: BattlePosition) -> bool:
	var source_pos := source.battle_pos
	var same_team := target_pos.role == source_pos.role
	match ability.target_type:
		Enums.TargetType.ANY:
			return true
		Enums.TargetType.ALLY_ANY:
			return same_team
		Enums.TargetType.ENEMY_ANY:
			return not same_team
		Enums.TargetType.ENEMY_NEAR:
			return not same_team and source_pos.row == 0 and target_pos.row == 0
		Enums.TargetType.ALLY_NEAR:
			return same_team and source_pos.row == target_pos.row
		Enums.TargetType.ENEMY_FAR:
			return not same_team and (source_pos.row == 1 or target_pos.row == 1)
		Enums.TargetType.ALLY_FAR:
			return same_team and source_pos.row != target_pos.row
		Enums.TargetType.SELF:
			return source_pos.as_array() == target_pos.as_array()
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
