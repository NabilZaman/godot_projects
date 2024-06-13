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
var feature: TileFeature

var should_hover := false
var should_unhover := false

## Called when the node enters the scene tree for the first time.
func _ready():
	#print("I'm Ready!")
	self.update_borders(border_style)
	self.hex_presentation.set_tile(tile_type)
	if self.feature != null:
		self.hex_presentation.add_child(self.feature)

func setup(grid_pos: GridPosition, border_style: PackedScene, tile_type: TileType,
			region: Region, layer: int = 0, feature_type = null,
			hover_signal = null, click_signal = null):
	self.grid_pos = grid_pos
	self.region = region
	self.hover_signal = hover_signal
	self.click_signal = click_signal
	self.border_style = border_style
	self.tile_type = tile_type
	self.layer = layer
	if feature_type != null:
		self.feature = feature_type.new()
		self.feature.tile = self
		self.feature.position.y = -50
		
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

func hover(tile: HexTile) -> void:
	hex_presentation.select()
	if self.feature != null:
		if tile == self:
			self.feature.focus()
		else:
			self.feature.unfocus()

func unhover() -> void:
	hex_presentation.deselect()
	if self.feature != null:
		self.feature.unfocus()

func calculate_border_visibility(neighbors: Array[GridPosition]) -> Array[float]:
	var border_visibility: Array[float] = []
	border_visibility.resize(6)
	for i in range(len(neighbors)):
		var neighbor_tile = HexGrid.get_tile(neighbors[i])
		var border_vis := 1.0
		if neighbor_tile == null:
			border_vis = 1.0 # draw full borders around edge of map
		elif neighbor_tile.region == self.region:
			border_vis = 0.02 # draw no border within a region
		elif neighbor_tile.region.kingdom == self.region.kingdom:
			border_vis = 0.35 # draw lighter borders between regions of the same kingdom
		border_visibility[i] = border_vis
	return border_visibility

func update_borders(border_style: PackedScene = null) -> void:
	if border_style != null:
		hex_presentation.set_border_style(border_style)
	var neighbors := grid_pos.neighbors()
	var border_visibility := calculate_border_visibility(neighbors)
	hex_presentation.set_borders(border_visibility)

# Returns the list of actions available to perform on this tile
func get_actions() -> Array[TileAction]: #TODO: THESE ARE GOING OUT OF SCOPE AND BEING REAPED
	var actions: Array[TileAction] = []
	if self.feature != null:
		actions.append_array(feature.get_actions())
	return actions

func collect_resources() -> Array[GameResource]:
	if self.feature != null:
		return self.feature.production()
	else:
		return []
