class_name Tile
extends Resource

var pos: Vector2i
var grid: TileGrid # TODO move this parent ref

var am_selected := false
var selected_pos: Vector2
var selected_grid_pos: Vector2i

func move_left() -> void:
    self.pos += Vector2i(-1, 0)

func move_right() -> void:
    self.pos += Vector2i(1, 0)

func move_up() -> void:
    self.pos += Vector2i(0, -1)

func move_down() -> void:
    self.pos += Vector2i(0, 1)

func move_dir(dir: Enums.Direction) -> void:
    match dir:
        Enums.Direction.LEFT:
            move_left()
        Enums.Direction.RIGHT:
            move_right()
        Enums.Direction.UP:
            move_up()
        Enums.Direction.DOWN:
            move_down()

# Override
func occupied_positions() -> Array[Vector2i]:
    return []

# Override
func copy() -> Tile:
    var new_pos := Vector2i(pos)
    return Tile.new(new_pos)

func _init(pos: Vector2i) -> void:
    self.pos = pos
    self.grid = null

