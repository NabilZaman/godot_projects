class_name TargetSelf
extends EffectRange

func find_effected_units(_battle: Battle, source: CombatUnit, _target: CombatUnit) -> Array[CombatUnit]:
    return [source]
