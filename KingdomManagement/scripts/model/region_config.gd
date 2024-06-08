class_name RegionConfig
extends Resource

var name: String
var selectable: bool
var grid_x_offset: int
var grid_y_offset: int
var tiles: Array[TileConfig]

func _init(name: String, selectable: bool, pos: Array, tiles: Array[TileConfig]) -> void:
	self.name = name
	self.selectable = selectable
	self.grid_x_offset = pos[0]
	self.grid_y_offset = pos[1]
	self.tiles = tiles
	
	

