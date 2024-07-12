class_name StateTransition
extends Resource

var initial_state: GridState
var tile_index: int
var direction: Enums.Direction

func _init(initial_state: GridState, tile_index: int, direction: Enums.Direction) -> void:
    self.initial_state = initial_state
    self.tile_index = tile_index
    self.direction = direction