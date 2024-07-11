class_name GameGrid
extends Control


const COLUMNS := 4
const ROWS := 5

var tiles: Dictionary = {}
var occupied: Dictionary = {}

signal move_made()

func get_tiles() -> Array[Tile]:
	var children: Array[Tile] = []
	children.assign(get_children())
	return children

func is_occupied(pos: Vector2i) -> bool:
	for child in get_tiles():
		if pos in child.occupied_positions():
			return true
	return false

func load_state(state: GridState, rerender: bool = true) -> void:
	# for each child, load its position from the state
	# update each childs position based on the grid pos
	var children: Array[Tile] = get_tiles()
	var new_positions: Array[Vector2i] = state.as_array(false)
	for i in range(len(children)):
		var child := children[i]
		child.pos = new_positions[i]
		if rerender:
			child.update_global_pos()

func dump_state() -> GridState:
	var grid_positions: Array[Vector2i] = []
	for child in get_tiles():
		grid_positions.append(child.pos)
	return GridState.from_array(grid_positions)


# detects if the grid has been won
func has_won() -> bool:
	return get_child(0).pos == Vector2i(1, 3)

func on_tile_move() -> void:
	move_made.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tiles():
		tiles[child.pos] = child
		child.moved.connect(on_tile_move)

