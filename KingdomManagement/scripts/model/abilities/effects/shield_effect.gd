class_name ShieldEffect
extends AbilityEffect

var potency: float

# Override
func apply_unit_effect(_battle: Battle, source: CombatUnit, target: CombatUnit) -> void:
    var shields := calculate_shields(source)
    target.apply_shields(int(shields))

func calculate_shields(source: CombatUnit) -> float:
    # TODO: should we use stats somehow?
    return source.troops() * self.potency


func _init(effect_range: EffectRange, potency: float = 0.25) -> void:
    super(Enums.EffectType.SHIELD, effect_range)
    assert( potency >= 0.0 and potency <= 1.0 )
    self.potency = potency
