class_name TileType
extends Resource

var _texture: Resource

func texture() -> Resource:
	return _texture

func embelishments() -> Array[Node2D]:
	return []

func _init(_texture: Resource) -> void:
	self._texture = _texture

