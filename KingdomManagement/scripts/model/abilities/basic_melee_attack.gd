class_name BasicMeleeAttack
extends CombatAbility

func _init(name: String = "Melee Attack") -> void:
    var damage_effect = DamageEffect.new(Enums.DamageType.PHYSICAL, SingleTarget.new())
    super(name, Enums.TargetType.ENEMY_NEAR, [damage_effect])
