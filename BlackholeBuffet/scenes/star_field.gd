extends Node2D



const CELL_WIDTH = 30
const CELL_HEIGHT = 30
const INITIAL_FIELD_WIDTH = 1920
const INITIAL_FIELD_HEIGHT = 1080
const INITIAL_CELL_COLS = INITIAL_FIELD_WIDTH / CELL_WIDTH
const INITIAL_CELL_ROWS = INITIAL_FIELD_HEIGHT / CELL_HEIGHT

@export var STAR_RAD = 1
@export var STAR_CHANCE = 0.4

var rng = RandomNumberGenerator.new()

var min_cell_row: int
var max_cell_row: int # actually one-past-the-max for 0-indexing purposes
var min_cell_col: int
var max_cell_col: int # actually one-past-the-max for 0-indexing purposes

# mapping from cell coord (Vector2i) -> Star Position in global coords (Vector2)
var star_positions: Dictionary = {}

@onready var player_node: PlayerBlackHole = %PlayerBlackHole

func pick_random_star_pos() -> Vector2:
	var xpos := rng.randf_range(STAR_RAD, CELL_WIDTH - STAR_RAD)
	var ypos := rng.randf_range(STAR_RAD, CELL_HEIGHT - STAR_RAD)
	return Vector2(xpos, ypos)

func refresh_star_row(row_index: int) -> void:
	var yoffset := (row_index - min_cell_row) * CELL_HEIGHT
	for col in range(min_cell_col, max_cell_col):
		if rng.randf() > STAR_CHANCE:
			continue
		var xoffset := (col - min_cell_col) * CELL_WIDTH
		var pos_in_cell := pick_random_star_pos()
		var pos := Vector2(xoffset + pos_in_cell.x, yoffset + pos_in_cell.y)
		star_positions[Vector2i(col, row_index)] = pos

func refresh_star_col(col_index: int) -> void:
	var xoffset := (col_index - min_cell_col) * CELL_WIDTH
	for row in range(min_cell_row, max_cell_row):
		if rng.randf() > STAR_CHANCE:
			continue
		var yoffset := (row - min_cell_row) * CELL_HEIGHT
		var pos_in_cell := pick_random_star_pos()
		var pos = Vector2(xoffset + pos_in_cell.x, yoffset + pos_in_cell.y)
		star_positions[Vector2i(col_index, row)] = pos

func clear_star_row(row_index: int) -> void:
	for col in range(min_cell_col, max_cell_col):
		star_positions.erase(Vector2i(col, row_index))

func clear_star_col(col_index: int) -> void:
	for row in range(min_cell_row, max_cell_row):
		star_positions.erase(Vector2i(col_index, row))

func add_row(end: bool) -> void:
	if end:
		max_cell_row += 1
		refresh_star_row(max_cell_row-1)
	else:
		min_cell_row -= 1
		refresh_star_row(min_cell_row)

func add_col(end: bool) -> void:
	if end:
		max_cell_col += 1
		refresh_star_col(max_cell_col-1)
	else:
		min_cell_col -= 1
		refresh_star_col(min_cell_col)

func remove_row(end: bool) -> void:
	if end:
		max_cell_row -= 1
		clear_star_row(max_cell_row)
	else:
		min_cell_row += 1
		clear_star_row(min_cell_row - 1)

func remove_col(end: bool) -> void:
	if end:
		max_cell_col -= 1
		clear_star_col(max_cell_col)
	else:
		min_cell_col += 1
		clear_star_col(min_cell_col - 1)

func _draw() -> void:
	for star_pos in star_positions.values():
		draw_circle(star_pos, STAR_RAD, Color.WHITE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.min_cell_row = 0
	self.max_cell_row = INITIAL_CELL_ROWS
	self.min_cell_col = 0
	self.max_cell_col = INITIAL_CELL_COLS
	for row in INITIAL_CELL_ROWS:
		refresh_star_row(row)

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
