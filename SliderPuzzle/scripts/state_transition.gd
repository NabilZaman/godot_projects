class_name StateTransition
extends Resource

var initial_state: GridState
var tile: Tile
var direction: Enums.Direction

func _init(initial_state: GridState, tile: Tile, direction: Enums.Direction) -> void:
    self.initial_state = initial_state
    self.tile = tile
    self.direction = direction