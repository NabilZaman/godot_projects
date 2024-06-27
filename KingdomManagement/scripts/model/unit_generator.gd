class_name UnitGenerator
extends Object



static func random_swordsman() -> CombatUnit:
    var unit_type = Swordsman.new()
    var generic_sprite = load("res://sprites/Commanders/Smiley.png")
    var random_stats = CombatStats.new(
        10, 10
    )
    var random_commander = Commander.new(
        "Random Swordsman", generic_sprite, random_stats, unit_type
    )
    const troops := 150
    var unit = CombatUnit.new(unit_type, random_commander, troops, BattlePosition.new(0, 1))
    return unit


static func random_archer() -> CombatUnit:
    var unit_type = Archer.new()
    var generic_sprite = load("res://sprites/Commanders/Smiley.png")
    var random_stats = CombatStats.new(
        10, 10
    )
    var random_commander = Commander.new(
        "Random Archer", generic_sprite, random_stats, unit_type
    )
    const troops := 150
    var unit = CombatUnit.new(unit_type, random_commander, troops, BattlePosition.new(0, 1))
    return unit


static func random_shieldbearer() -> CombatUnit:
    var unit_type = ShieldBearer.new()
    var generic_sprite = load("res://sprites/Commanders/Smiley.png")
    var random_stats = CombatStats.new(
        10, 10
    )
    var random_commander = Commander.new(
        "Random Shieldbearer", generic_sprite, random_stats, unit_type
    )
    const troops := 150
    var unit = CombatUnit.new(unit_type, random_commander, troops, BattlePosition.new(0, 1))
    return unit


