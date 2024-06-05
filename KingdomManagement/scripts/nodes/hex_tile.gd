class_name HexTile
extends Node2D

var territory: Territory = Territory.new("", Enums.TerritoryOwner.NPC)
@onready var hex_presentation: HexPresentation = $HexPresentation

var grid_pos: GridPosition
var hover_signal
var click_signal
var border_style: PackedScene
var tile_style: Resource

var should_hover := false
var should_unhover := false

## Called when the node enters the scene tree for the first time.
func _ready():
	print("I'm Ready!")
	self.update_borders(border_style)
	self.hex_presentation.set_tile(tile_style)
	
# TODO: Handle tiles containing "tile features"
# These will be raw materials like wheat, ore, and lumber
# or could be developed features like mines on top of the raw materials.

func setup(grid_pos: GridPosition, border_style: PackedScene, tile_style: Resource,\
			hover_signal = null, click_signal = null):
	self.grid_pos = grid_pos
	self.hover_signal = hover_signal
	self.click_signal = click_signal
	self.border_style = border_style
	self.tile_style = tile_style

func on_click(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		click_signal.emit()
		print(self.name + ": You clicked me!")

func _on_mouse_entered():
	print(self.name + ": hovered")
	if hover_signal:
		hover_signal.emit()

func hover() -> void:
	hex_presentation.select()

func unhover() -> void:
	hex_presentation.deselect()

func update_borders(border_style: PackedScene = null) -> void:
	if border_style != null:
		hex_presentation.set_border_style(border_style)
	# draw the appropriate borders based on your neighbor information
	# this requires a reference to your parent province

