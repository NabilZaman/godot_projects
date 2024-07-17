class_name StateTransition
extends Resource

var initial_state: GridState
@export var tile_pos: Vector2i
@export var direction: Enums.Direction

func _init(initial_state: GridState = null, tile_pos: Vector2i = Vector2i(), direction: Enums.Direction = Enums.Direction.DOWN) -> void:
    self.initial_state = initial_state
    self.tile_pos = tile_pos
    self.direction = direction