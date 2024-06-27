class_name CombatAbility
extends Resource

## Configuration ##
# The name of this ability, can be customized per unit type
var _name: String
# The target type, determined who this attack can target
var target_type: Enums.TargetType
# The cost in energy to the unit using this attack.
var energy_cost: int
# Indicates whether this attack will (by default) trigger counter-attack damage
var trigger_counter: bool

## General ##
var effects: Array[AbilityEffect] = []

func apply(battle: Battle, source: CombatUnit, target: CombatUnit) -> void:
    for effect in effects:
        effect.apply(battle, source, target)

func add_effect(effect: AbilityEffect) -> void:
    self.effects.append(effect)

func name() -> String:
    return _name

func _init(name: String, target_type: Enums.TargetType, effects: Array[AbilityEffect],
            energy_cost: int = 1, trigger_counter: bool = true) -> void:
    self._name = name
    self.target_type = target_type
    self.effects = effects
    self.energy_cost = energy_cost
    self.trigger_counter = trigger_counter
