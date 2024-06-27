class_name BasicRangedAttack
extends CombatAbility


func _init(name: String = "Ranged Attack") -> void:
    var damage_effect = DamageEffect.new(Enums.DamageType.PHYSICAL, SingleTarget.new())
    super(name, Enums.TargetType.ENEMY_ANY, [damage_effect], 1, false)
