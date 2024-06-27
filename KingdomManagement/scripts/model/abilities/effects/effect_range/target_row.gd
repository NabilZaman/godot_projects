class_name TargetRow
extends EffectRange

func find_effected_units(battle: Battle, _source: CombatUnit, target: CombatUnit) -> Array[CombatUnit]:
    var targets: Array[CombatUnit] = []
    var allies: Array[CombatUnit]
    if target in battle.attackers:
        allies = battle.attackers
    else:
        allies = battle.defenders
    
    for ally in allies:
        if ally.battle_pos.row == target.battle_pos.row:
            targets.append(ally)
    return targets
