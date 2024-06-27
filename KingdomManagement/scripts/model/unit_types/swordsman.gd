class_name Swordsman
extends UnitType

func basic_ability() -> CombatAbility:
    return BasicMeleeAttack.new("Sword Attack")

func special_ability() -> CombatAbility:
    return StrongMeleeAttack.new("Heavy Sword Attack")

func _init() -> void:
    var base_stats := CombatStats.new(
        40,
        30
    )
    super("Swordsman", base_stats)
