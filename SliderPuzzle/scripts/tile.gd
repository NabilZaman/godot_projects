class_name Tile
extends TextureButton

const CELL_HEIGHT := 100
const CELL_WIDTH := 100

@export var pos: Vector2i

@onready var grid: GameGrid = %GameGrid

var am_selected := false
var selected_pos: Vector2
var selected_grid_pos: Vector2i

func grid_to_global_pos(grid_pos: Vector2i) -> Vector2:
    return Vector2(grid_pos.x * CELL_WIDTH, grid_pos.y * CELL_HEIGHT)

# Calculates the nearest grid position given a global coordinate position
func global_to_grid_pos(global_pos: Vector2) -> Vector2i:
    var xpos: int = roundi( global_pos.x / CELL_WIDTH )
    var ypos: int = roundi( global_pos.y / CELL_HEIGHT )
    return Vector2i(xpos, ypos)

func can_move_left() -> bool:
    # Record the left-most position of this tile in each row
    var leftmost_col_per_row := {}
    for occupied_pos in occupied_positions():
        if occupied_pos.y not in leftmost_col_per_row or leftmost_col_per_row[occupied_pos.y] > occupied_pos.x:
            leftmost_col_per_row[occupied_pos.y] = occupied_pos.x
    for row in leftmost_col_per_row:
        var col: int = leftmost_col_per_row[row]
        if col <= 0 or grid.is_occupied(Vector2i(col - 1, row)):
            return false
    return true

func can_move_right() -> bool:
    # Record the right-most position of this tile in each row
    var rightmost_col_per_row := {}
    for occupied_pos in occupied_positions():
        if occupied_pos.y not in rightmost_col_per_row or rightmost_col_per_row[occupied_pos.y] < occupied_pos.x:
            rightmost_col_per_row[occupied_pos.y] = occupied_pos.x
    for row in rightmost_col_per_row:
        var col: int = rightmost_col_per_row[row]
        if col >= grid.COLUMNS-1 or grid.is_occupied(Vector2i(col + 1, row)):
            return false
    return true

func can_move_up() -> bool:
    # Record the top-most position of this tile in each col
    var topmost_row_per_col := {}
    for occupied_pos in occupied_positions():
        if occupied_pos.x not in topmost_row_per_col or topmost_row_per_col[occupied_pos.x] > occupied_pos.y:
            topmost_row_per_col[occupied_pos.x] = occupied_pos.y
    for col in topmost_row_per_col:
        var row: int = topmost_row_per_col[col]
        if row <= 0 or grid.is_occupied(Vector2i(col, row-1)):
            return false
    return true

func can_move_down() -> bool:
    # Record the top-most position of this tile in each col
    var bottommost_row_per_col := {}
    for occupied_pos in occupied_positions():
        if occupied_pos.x not in bottommost_row_per_col or bottommost_row_per_col[occupied_pos.x] < occupied_pos.y:
            bottommost_row_per_col[occupied_pos.x] = occupied_pos.y
    for col in bottommost_row_per_col:
        var row: int = bottommost_row_per_col[col]
        if row >= grid.ROWS-1 or grid.is_occupied(Vector2i(col, row+1)):
            return false
    return true

func can_move_dir(dir: Enums.Direction) -> bool:
    match dir:
        Enums.Direction.LEFT:
            return can_move_left()
        Enums.Direction.RIGHT:
            return can_move_right()
        Enums.Direction.UP:
            return can_move_up()
        Enums.Direction.DOWN:
            return can_move_down()
    return false

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

# The highest y value allowed: either the current grid value or the grid value of the position above us if we can move up
func get_up_bound() -> float:
    if can_move_up():
        return grid_to_global_pos(pos + Vector2i(0, -1)).y
    else:
        return grid_to_global_pos(pos).y

# The lowest y value allowed: either the current grid value or the grid value of the position below us if we can move down
func get_down_bound() -> float:
    if can_move_down():
        return grid_to_global_pos(pos + Vector2i(0, 1)).y
    else:
        return grid_to_global_pos(pos).y

# The lowest x value allowed: either the current grid value or the grid value of the position left of us if we can move left
func get_left_bound() -> float:
    if can_move_left():
        return grid_to_global_pos(pos + Vector2i(-1, 0)).x
    else:
        return grid_to_global_pos(pos).x

# The lowest x value allowed: either the current grid value or the grid value of the position left of us if we can move left
func get_right_bound() -> float:
    if can_move_right():
        return grid_to_global_pos(pos + Vector2i(1, 0)).x
    else:
        return grid_to_global_pos(pos).x


func update_global_pos(should_tween: bool = false) -> void:
    var new_position := grid_to_global_pos(self.pos)
    if should_tween:
        var tween = get_tree().create_tween()
        tween.tween_property(self, "position", new_position, Config.STEP_TIME_SEC)
    else:
        self.position = new_position


func update_grid_pos() -> void:
    var old_pos := pos    
    self.pos = global_to_grid_pos(self.position)
    if old_pos != pos:
        grid.update_occupied()


func on_selected() -> void:
    # record the mouse position
    self.selected_pos = get_viewport().get_mouse_position()
    self.selected_grid_pos = pos
    self.am_selected = true
    

func on_unselected() -> void:
    # reset the position of this tile to the grid position
    self.position = grid_to_global_pos(pos)
    self.am_selected = false


# Override
func occupied_positions() -> Array[Vector2i]:
    return []


func _process(_delta: float) -> void:
    if am_selected:
        # calculate bounds, update position clamped to within bounds
        # bounds calculated from grid position up/down, left/right converted to global coords
        var projection = grid_to_global_pos(selected_grid_pos) + selection_move_distance()
        var bounded_x = clamp(projection.x, get_left_bound(), get_right_bound())
        var bounded_y = clamp(projection.y, get_up_bound(), get_down_bound())
        self.position = Vector2(bounded_x, bounded_y)
        update_grid_pos()


# Returns the difference between where the mouse began and ended its movement.
func selection_move_distance() -> Vector2:
    return get_viewport().get_mouse_position() - self.selected_pos

