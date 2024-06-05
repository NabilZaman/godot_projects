extends Node2D

var xmin := -15
var xmax := 15
var ymin := -15
var ymax := 15

const HEX_TILE = preload("res://scenes/hex_tile.tscn")

signal hover_signal

func _ready():
	hover_signal.connect(fake_hover)
	fill_boundary()

func fill_boundary() -> void:
	print("Hello?")
	for x in range(xmin, xmax):
		for y in range(ymin, ymax):
			var xpos = 2 * x + (y % 2)
			var ypos = y
			var grid_pos = GridPosition.new(xpos, ypos)
			print("Placing tile at " + str(grid_pos.as_vector()))
			if not HexGrid.tile_present(grid_pos):
				var tile = HEX_TILE.instantiate()
				tile.setup(grid_pos, Enums.BorderStyles.STYLE1, Enums.TileStyles.BLUE, hover_signal, null)
				#tile.hex_presentation.set_borders([0, 1, 2, 3, 4, 5])
				HexGrid.place_tile(tile, false)
				self.add_child(tile)

func fake_hover():
	Signals.map_focus_changed.emit(null)
