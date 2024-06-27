class_name CompositeRange
extends EffectRange

var component_ranges: Array[EffectRange]

func find_effected_units(battle: Battle, source: CombatUnit, target: CombatUnit) -> Array[CombatUnit]:
    var union := {} # use a dummy dictionary as a hash set
    for e_range in component_ranges:
        for unit in e_range.find_effected_units(battle, source, target):
            union[unit] = null
    return union.keys()


func _init(component_ranges: Array[EffectRange]) -> void:
    self.component_ranges = component_ranges