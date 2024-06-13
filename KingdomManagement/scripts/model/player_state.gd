class_name Player
extends Resource

var max_actions: float = 2.0
var actions: float
var name: String
var kingdom: Kingdom

var resource_bank: Dictionary = {}

func adjust_resource(resource: GameResource) -> void:
	if resource.type not in resource_bank:
		resource_bank[resource.type] = 0
	resource_bank[resource.type] += resource.qty

func get_resource(type: Enums.ResourceType) -> GameResource:	
	return GameResource.new(type, resource_bank.get(type, 0))

# Checks if we have at least a specified qty of a resource
func has_min_resource(resource: GameResource) -> bool:
	return self.get_resource(resource.type).qty >= resource.qty

func refresh_actions():
	self.actions = self.max_actions
	Signals.actions_changed.emit()

func _init(name: String = "Nidas", max_actions: int = 2) -> void:
	self.name = name
	self.max_actions = max_actions
	self.actions = max_actions

