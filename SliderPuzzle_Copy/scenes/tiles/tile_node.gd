class_name TileNode
extends TextureButton

var tile: Tile

var am_selected := false
var selected_pos: Vector2
var selected_grid_pos: Vector2i

# When a player physically moves the tile
signal moved()
signal selected()

func update_global_pos(should_tween: bool = false) -> void:
    var new_position := Config.grid_to_global_pos(tile.pos)
    if should_tween:
        var tween := get_tree().create_tween()
        tween.tween_property(self, "position", new_position, Config.STEP_TIME_SEC).from_current()
    else:
        self.set_position(new_position)

func update_grid_pos() -> void:
    var old_pos := tile.pos
    tile.pos = Config.global_to_grid_pos(self.position)
    if old_pos != tile.pos:
        moved.emit()

func on_selected() -> void:
    # record the mouse position
    self.selected_pos = get_viewport().get_mouse_position()
    self.selected_grid_pos = tile.pos
    self.am_selected = true
    selected.emit()
    
func on_unselected() -> void:
    # reset the position of this tile to the grid position
    self.position = Config.grid_to_global_pos(tile.pos)
    self.am_selected = false

# Override  
func occupied_positions() -> Array[Vector2i]:
    return []

func handle_movement(left_bound: float, right_bound: float, up_bound: float, down_bound: float) -> void:
    if am_selected:
        var projection = Config.grid_to_global_pos(selected_grid_pos) + selection_move_distance()
        var bounded_x = clamp(projection.x, left_bound, right_bound)
        var bounded_y = clamp(projection.y, up_bound, down_bound)
        self.position = Vector2(bounded_x, bounded_y)
        update_grid_pos()

# Returns the difference between where the mouse began and ended its movement.
func selection_move_distance() -> Vector2:
    return get_viewport().get_mouse_position() - self.selected_pos

func set_tile(tile: Tile) -> void:
    self.tile = tile
