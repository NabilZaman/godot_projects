class_name GameResource
extends Resource

var type: Enums.ResourceType
var qty: int

func _init(type: Enums.ResourceType, qty: int) -> void:
	self.type = type
	self.qty = qty

