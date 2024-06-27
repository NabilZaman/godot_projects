class_name BasicBlock
extends CombatAbility

func _init(name: String = "Block") -> void:
    var shield_effect = ShieldEffect.new(SingleTarget.new())
    super(name, Enums.TargetType.ALLY_NEAR, [shield_effect], 1, false)
