class_name Region
extends Node2D

const HEX_TILE = preload("res://scenes/hex_tile.tscn")

var border_style: PackedScene
var region_name: String
var kingdom: Kingdom
var selectable: bool

signal click_signal(tile: HexTile)
signal hover_signal(tile: HexTile)

func _ready() -> void:
	hover_signal.connect(on_tile_hover)
	if selectable:
		click_signal.connect(on_click)
		Signals.map_focus_changed.connect(on_hover)

func add_hex(grid_pos: GridPosition, border_style: PackedScene, tile_type: TileType, layer: int) -> void:
	var tile = HEX_TILE.instantiate()
	tile.setup(grid_pos, border_style, tile_type, self, layer, hover_signal, click_signal)
	HexGrid.place_tile(tile)
	self.add_child(tile)

func on_click(tile: HexTile) -> void:
	Signals.open_tile_menu.emit(tile)

func on_tile_hover(tile: HexTile):
	Signals.map_focus_changed.emit(self)

func on_hover(region: Region) -> void:
	if region == self:
		for tile in self.get_children():
			tile.hover()
	else:
		for tile in self.get_children():
			tile.unhover()

# Returns the list of actions available to perform on this region
func get_actions() -> Array[RegionAction]:
	return []

# needs to have 1 capital, needs to have # of forts = level of province/capital
func _init(name: String, kingdom: Kingdom, pos: Array, selectable: bool, tiles: Array[TileConfig]) -> void:
	self.region_name = name
	self.kingdom = kingdom
	var x_offset = pos[0]
	var y_offset = pos[1]
	self.selectable = selectable
	for tile in tiles:
		self.add_hex(GridPosition.new(tile.grid_x + x_offset, tile.grid_y + y_offset), kingdom.border_style, tile.tile_type, tile.layer)
	#TODO: should we validate capitals/forts?

