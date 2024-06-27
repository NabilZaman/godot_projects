class_name Commander
extends Resource

var is_unique: bool = false
var type: UnitType
var name: String
var portrait: Resource
var stats: CombatStats

func ultimate_ability() -> CombatAbility:
	return null

func _init(name: String, portrait: Resource, stats: CombatStats,
			type: UnitType, is_unique: bool = false) -> void:
	self.name = name
	self.portrait = portrait
	self.stats = stats
	self.type = type
	self.is_unique = is_unique

