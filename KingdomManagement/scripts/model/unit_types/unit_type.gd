class_name  UnitType
extends Resource

var type_name: String
var instrinsic_stats: CombatStats

# Override
func basic_ability() -> CombatAbility:
    return null

# Override
func special_ability() -> CombatAbility:
    return null


func _init(type_name: String, stats: CombatStats) -> void:
    self.type_name = type_name
    self.instrinsic_stats = stats
