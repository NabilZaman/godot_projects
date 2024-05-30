extends Node2D

var xinterval = 278
var yinterval = 203

var yoffset = 138

var rows = 10
var cols = 17 # The column width will alternate between cols and cols-1

const HEX_TILE = preload("res://scenes/hex_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for row in range(rows):
		var ypos = row * yinterval + yoffset
		var col_stagger = row % 2
		var xoffset = xinterval / 2 if col_stagger == 0 else xinterval
		for col in range(cols - col_stagger):
			var xpos = col * xinterval + xoffset
			var pos = Vector2(xpos, ypos)
			var new_tile = HEX_TILE.instantiate()
			new_tile.position = pos
			self.add_child(new_tile)
			
