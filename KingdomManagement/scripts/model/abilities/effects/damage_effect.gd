class_name DamageEffect
extends AbilityEffect

var damage_type: Enums.DamageType
var potency: float

# Override
func apply_unit_effect(_battle: Battle, source: CombatUnit, target: CombatUnit) -> void:
    var damage := cacluate_damage(source, target)
    target.apply_damage(int(damage))

# This calculates the final damage done, the defending unit then applies
# any remaining modifiers before taking the damage
func cacluate_damage(source: CombatUnit, target: CombatUnit) -> float:
    var adjusted_attack: float = clamp(source.stats().attack - target.stats().defence, 10.0, 100.0)
    return source.troops() * potency * adjusted_attack / 100.0 

func _init(damage_type: Enums.DamageType, effect_range: EffectRange, potency: float = 1.0) -> void:
    assert( potency >= 0.0 )
    super(Enums.EffectType.DAMAGE, effect_range)
    self.damage_type = damage_type
    self.potency = potency
