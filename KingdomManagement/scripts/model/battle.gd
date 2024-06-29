class_name Battle
extends Node

# value from 0.0 to 1.0 indicating how close the attackers are to winning
var morale: float
var turn_limit: int = 30
var turn_count: int

# unused for now, not sure if this will be used
var terrain: Object

var attackers: Array[CombatUnit]
var defenders: Array[CombatUnit] 

var player_attacking: bool

# signals for views to listen to
signal morale_changed()
signal turns_changed()

#TODO: Morale and turn counts are not being updated
func change_morale(delta: float) -> void:
    self.morale += delta
    morale_changed.emit(morale)

func change_turns(delta: int = 1) -> void:
    self.turn_count += delta
    turns_changed.emit(turn_count)


func _init(attackers: Array[CombatUnit], defenders: Array[CombatUnit], player_attacking: bool, initial_morale: float = 50.0) -> void:
    self.turn_count = 0
    self.attackers = attackers
    self.defenders = defenders
    self.player_attacking = player_attacking
    self.morale = initial_morale

