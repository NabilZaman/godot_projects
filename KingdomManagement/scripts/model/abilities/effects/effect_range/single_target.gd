class_name SingleTarget
extends EffectRange

func find_effected_units(_battle: Battle, _source: CombatUnit, target: CombatUnit) -> Array[CombatUnit]:
    return [target]
