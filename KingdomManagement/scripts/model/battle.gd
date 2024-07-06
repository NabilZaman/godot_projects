class_name Battle
extends Node

# value from 0.0 to 100.0 indicating how close the attackers are to winning
var morale: float
var morale_modifier: float
var turn_limit: int = 30
var turn_count: int

# unused for now, not sure if this will be used
var terrain: Object

# These two sets of units are the same, but with different perspectives
# (attackers/defender vs player/enemy)
var attackers: Array[CombatUnit]
var defenders: Array[CombatUnit]

var player_units: Array[CombatUnit]
var enemy_units: Array[CombatUnit] 
##

var player_attacking: bool

var attackers_initial: int
var defenders_initial: int

# signals for views to listen to
signal morale_changed()
signal turns_changed()


func add_morale_modifier(amount: float, is_attacker: bool) -> void:
    if is_attacker:
        amount *= -1
    self.morale_modifier += amount

# Computes the current : max troop ratio across a group of units
# range: 0 <= x <= 1
func compute_team_strength_ratio(units: Array[CombatUnit]) -> float:
    var current_troops := 0.0
    var max_troops := 0.0
    for unit in units:
        current_troops += unit.num_troops
        max_troops += unit.max_troops
    return current_troops / max_troops if max_troops > 0.0 else 0.0

func compute_base_morale(attacker_str: float, defender_str: float) -> float:
    var result: float
    # we only divide by the (strictly) greater value, ensuring the denominator is never 0
    if attacker_str > defender_str:
        result = 100.0 - defender_str / attacker_str * 50.0
    else:
        result = attacker_str / defender_str * 50.0
    return result

func recompute_morale() -> void:
    var old_val := morale
    var player_strength := compute_team_strength_ratio(player_units)
    var enemy_strength := compute_team_strength_ratio(enemy_units)

    # if strength is equal, don't bother calculating; it's 50/50
    if player_strength == enemy_strength:
        self.morale = 50.0
    else:
        self.morale = clamp(compute_base_morale(player_strength, enemy_strength) + morale_modifier, 0.0, 100.0)

    if morale != old_val:
        print("New morale %.2f (%.2f / %.2f)" % [morale, player_strength, enemy_strength])
        morale_changed.emit()


func advance_turns(delta: int = 1) -> void:
    self.turn_count += delta
    turns_changed.emit()


func _init(attackers: Array[CombatUnit], defenders: Array[CombatUnit], player_attacking: bool, initial_morale: float = 50.0) -> void:
    self.turn_count = 0
    self.player_attacking = player_attacking
    self.attackers = attackers
    self.defenders = defenders
    if player_attacking:
        self.player_units = attackers
        self.enemy_units = defenders
    else:
        self.player_units = defenders
        self.enemy_units = attackers
    self.morale = initial_morale

