class_name TargetGroup
extends EffectRange

func find_effected_units(battle: Battle, _source: CombatUnit, target: CombatUnit) -> Array[CombatUnit]:
    var allies: Array[CombatUnit]
    if target in battle.attackers:
        allies = battle.attackers
    else:
        allies = battle.defenders
    
    return allies
