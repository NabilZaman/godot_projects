class_name GameGrid
extends Control


const COLUMNS := 4
const ROWS := 5

var tiles: Dictionary = {}
var occupied: Dictionary = {}

func get_tiles() -> Array[Tile]:
	var children: Array[Tile] = []
	children.assign(get_children())
	return children

func is_occupied(pos: Vector2i) -> bool:
	return occupied[pos]

func update_occupied() -> void:
	for x in range(COLUMNS):
		for y in range(ROWS):
			occupied[Vector2i(x, y)] = false
	for child in get_tiles():
		for occupied_pos in child.occupied_positions():
			occupied[occupied_pos] = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tiles():
		tiles[child.pos] = child
	update_occupied()



# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
