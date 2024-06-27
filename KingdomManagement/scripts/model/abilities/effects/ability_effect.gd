class_name AbilityEffect
extends Resource

var type: Enums.EffectType
var effect_range: EffectRange

var helpful_types: Array[Enums.EffectType] = [
    Enums.EffectType.HEAL,
    Enums.EffectType.SHIELD,
    Enums.EffectType.BUFF,
]

var harmful_types: Array[Enums.EffectType] = [
    Enums.EffectType.DAMAGE,
    Enums.EffectType.DEBUFF,
]

func is_helpful() -> bool:
    return type in helpful_types

func is_harmful() -> bool:
    return type in harmful_types

func is_battle() -> bool:
    return type == Enums.EffectType.BATTLE

# Apply the effect to the effected targets
func apply(battle: Battle, source: CombatUnit, target: CombatUnit) -> void:
    apply_battle_effect(battle, source)

    var effected := effect_range.find_effected_units(battle, source, target)
    for unit in effected:
        apply_unit_effect(battle, source, unit)

# Override
func apply_battle_effect(_battle: Battle, _source: CombatUnit) -> void:
    pass

# Override
func apply_unit_effect(_battle: Battle, _source: CombatUnit, _target: CombatUnit) -> void:
    pass

func _init(type: Enums.EffectType, effect_range: EffectRange) -> void:
    self.type = type
    self.effect_range = effect_range