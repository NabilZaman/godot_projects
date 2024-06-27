class_name ShieldBearer
extends UnitType

const potency_conf := 0.2
const mitigation_conf := 0.6


func basic_ability() -> CombatAbility:
    return BasicMeleeAttack.new("Charge")

func special_ability() -> CombatAbility:
    return BasicBlock.new("Shield Ally")

func _init() -> void:
    var base_stats := CombatStats.new(
        20,
        40
    )
    super("Shield Bearer", base_stats)
