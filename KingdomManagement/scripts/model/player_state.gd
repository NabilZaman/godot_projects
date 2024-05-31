class_name Player
extends Resource

var max_actions: int = 2
var gold: int
var actions: int
var name: String

func refresh_actions():
	self.actions = self.max_actions
	Signals.actions_changed.emit(self.actions)

func _init(name: String = "Nidas", gold: int = 10, max_actions: int = 2) -> void:
	self.name = name
	self.gold = gold
	self.max_actions = max_actions
	self.actions = max_actions

