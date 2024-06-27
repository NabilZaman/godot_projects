class_name StrongMeleeAttack
extends CombatAbility

const power_factor := 1.5

func _init(name: String = "Strong Melee Attack") -> void:
    var damage_effect = DamageEffect.new(Enums.DamageType.PHYSICAL, SingleTarget.new(), power_factor)
    super(name, Enums.TargetType.ENEMY_NEAR, [damage_effect], 2)
