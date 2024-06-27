class_name Archer
extends UnitType


# Override
func basic_ability() -> CombatAbility:
    return BasicRangedAttack.new("Bow Shot")

func special_ability() -> CombatAbility:
    return StrongRangedAttack.new("Heavy Bow Shot")

func _init() -> void:
    var base_stats := CombatStats.new(
        40,
        20
    )
    super("Shield Bearer", base_stats)
