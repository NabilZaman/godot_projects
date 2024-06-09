class_name HexTile
extends Node2D

@onready var hex_presentation: HexPresentation = $HexPresentation
const ROLLING_WAVE = preload("res://scenes/rolling_wave.tscn")

var grid_pos: GridPosition
var hover_signal
var click_signal
var border_style: PackedScene
var tile_type: TileType
var region: Region
var layer: int

var should_hover := false
var should_unhover := false

## Called when the node enters the scene tree for the first time.
func _ready():
	#print("I'm Ready!")
	self.update_borders(border_style)
	self.hex_presentation.set_tile(tile_type)

func setup(grid_pos: GridPosition, border_style: PackedScene, tile_type: TileType,\
			region: Region, layer: int = 0, hover_signal = null, click_signal = null):
	self.grid_pos = grid_pos
	self.region = region
	self.hover_signal = hover_signal
	self.click_signal = click_signal
	self.border_style = border_style
	self.tile_type = tile_type
	self.layer = layer
	self.z_index = grid_pos.y

func on_click(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if click_signal:
			click_signal.emit(self)
		#print(self.name + ": You clicked me!")

func _on_mouse_entered():
	#print(self.name + ": hovered")
	if hover_signal:
		hover_signal.emit(self)

func hover() -> void:
	hex_presentation.select()

func unhover() -> void:
	hex_presentation.deselect()

func update_borders(border_style: PackedScene = null) -> void:
	if border_style != null:
		hex_presentation.set_border_style(border_style)
	var border_placements: Array[int] = []
	var neighbors = grid_pos.neighbors()
	for i in range(len(neighbors)):
		var neighbor_tile = HexGrid.get_tile(neighbors[i])
		if neighbor_tile == null or neighbor_tile.region != self.region:
			border_placements.append(i)
			#TODO: Handle bordering regions owned by the same kingdom differently
	hex_presentation.set_borders(border_placements)

# Returns the list of actions available to perform on this tile
func get_actions() -> Array[TileAction]:
	return []

