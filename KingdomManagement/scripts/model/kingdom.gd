class_name Kingdom
extends Node2D

var kingdom_name: String
var border_style: PackedScene
var regions: Array[Region]
var army: Army

#func _init(name: String, owner: Kingdom, pos: Array, selectable: bool, tiles: Array[TileConfig]) -> void:
func add_region(conf: RegionConfig):
	var region = Region.new(conf.name, self, [conf.grid_x_offset, conf.grid_y_offset], conf.selectable, conf.tiles)
	self.regions.append(region)
	self.add_child(region)
	

func _init(name: String, border_style: PackedScene, army_size: int,
		regions: Array[RegionConfig], is_player: bool = false) -> void:
	self.kingdom_name = name
	self.border_style = border_style
	if is_player:
		self.army = Army.new(army_size, Signals.troops_changed)
	else:
		self.army = Army.new(army_size)
	for region in regions:
		self.add_region(region)
		
