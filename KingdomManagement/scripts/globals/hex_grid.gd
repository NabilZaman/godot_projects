extends Node

var xinterval = 277
var yinterval = 202

var grid: Dictionary

const HEX_TILE = preload("res://scenes/hex_tile.tscn")

func place_tile(tile: HexTile, overwrite: bool = true) -> void:
	# store it in the grid for later access
	var grid_x = tile.grid_pos.x
	var grid_y = tile.grid_pos.y
	var grid_coord = Vector2i(grid_x, grid_y)
	if overwrite and grid.has(grid_coord):
		grid[grid_coord].queue_free()
	grid[grid_coord] = tile
	
	# Give the tile a position based on the global coordinate system
	var xoffset = 0 if grid_y % 2 == 0 else xinterval / 2
	var xpos = xinterval / 2 * grid_x
	var ypos = yinterval * grid_y
	tile.position = Vector2(xpos, ypos)
	tile.z_index = grid_y

func tile_present(grid_position: GridPosition) -> bool:
	return grid.has(grid_position.as_vector())
