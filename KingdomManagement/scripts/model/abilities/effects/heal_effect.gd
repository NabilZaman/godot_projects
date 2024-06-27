class_name HealEffect
extends AbilityEffect

var potency: float

# Override
func apply_unit_effect(_battle: Battle, source: CombatUnit, target: CombatUnit) -> void:
    var healing := calculate_healing(source)
    target.apply_healing(int(healing))

func calculate_healing(source: CombatUnit) -> float:
    # TODO: should we use stats somehow? magic?
    return source.troops() * self.potency


func _init(type: Enums.EffectType, effect_range: EffectRange, potency: float = 0.25) -> void:
    super(type, effect_range)
    assert( potency >= 0.0 and potency <= 1.0 )
    self.potency = potency