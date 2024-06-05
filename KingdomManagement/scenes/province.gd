class_name Province # Rethinking, I prefer the name "Region" as I think these will capture more than just political units
extends Node2D

const HEX_TILE = preload("res://scenes/hex_tile.tscn")
var tiles: Array[HexTile] = []
var border_style: PackedScene

signal click_signal()
signal hover_signal(enabled: bool)

# take some bool to indicate if you're selectable, this should inform the signal
# behaviors and handles the case of the ocean/mountainous/regions

func _ready() -> void:
	click_signal.connect(on_click)
	hover_signal.connect(on_tile_hover)
	Signals.map_focus_changed.connect(on_hover)
	
	# Setup for testing
	print("Getting province ready!")
	var border = Enums.BorderStyles.STYLE2
	var tile = Enums.TileStyles.GREEN
	self.add_hex(GridPosition.new(0, 0), border, tile)
	self.add_hex(GridPosition.new(2, 0), border, tile)
	self.add_hex(GridPosition.new(1, 1), border, tile)
	self.add_hex(GridPosition.new(-1, 1), border, tile)
	self.add_hex(GridPosition.new(1, -1), border, tile)
	self.add_hex(GridPosition.new(-1, -1), border, tile)


func add_hex(grid_pos: GridPosition, border_style: PackedScene, tile_style: Resource) -> void:
	var tile = HEX_TILE.instantiate()
	tile.setup(grid_pos, border_style, tile_style, hover_signal, click_signal)
	self.tiles.append(tile)
	HexGrid.place_tile(tile)
	self.add_child(tile)

func on_click() -> void:
	# TODO: Probably get rid of this territory thing
	var territory: Territory = Territory.new("", Enums.TerritoryOwner.NPC)
	Signals.open_tile_menu.emit(territory)

func on_tile_hover():
	Signals.map_focus_changed.emit(self)

func on_hover(province: Province) -> void:
	if province == self:
		for tile in tiles:
			tile.hover()
	else:
		for tile in tiles:
			tile.unhover()

