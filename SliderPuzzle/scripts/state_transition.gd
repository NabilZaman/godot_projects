class_name StateTransition
extends Resource

var initial_state: GridState
var tile_pos: Vector2i
var direction: Enums.Direction

func _init(initial_state: GridState, tile_pos: Vector2i, direction: Enums.Direction) -> void:
    self.initial_state = initial_state
    self.tile_pos = tile_pos
    self.direction = direction