class_name TileConfig
extends Resource

var grid_x: int
var grid_y: int
var tile_type: TileType
var feature_type
var layer: int

func _init(pos: Array, tile_type: TileType, feature_type = null, layer: int = 0) -> void:
	self.grid_x = pos[0]
	self.grid_y = pos[1]
	self.tile_type = tile_type
	self.feature_type = feature_type
	self.layer = layer

