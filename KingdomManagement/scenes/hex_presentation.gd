class_name HexPresentation
extends Node2D

var hex_border: HexBorder
@onready var tile: Sprite2D = $tile
var hover_displacement: Vector2
const border_pos = Vector2(0, -16)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Default Style
	set_border_style(Enums.BorderStyles.STYLE1)
	hover_displacement = Vector2(0, GameConfig.tile_hover_distance)


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

var selected = false

func select() -> void:
	if not selected:
		self.selected = true
		self.translate(hover_displacement)
	
func deselect() -> void:
	if selected:
		self.selected = false
		self.translate(-hover_displacement)

func set_borders(visible_segments: Array[int]) -> void:
	for i in range(6):
		var is_visible = i in visible_segments
		self.hex_border.set_segment(i, is_visible)

func set_border_style(style: PackedScene) -> void:
	# remove existing border, if any
	if self.hex_border != null:
		self.remove_child(hex_border)
		self.hex_border.queue_free()
	# add new border
	self.hex_border = style.instantiate()
	self.hex_border.position = border_pos
	self.add_child(hex_border)

func set_tile(style: Resource) -> void:
	self.tile.texture = style
	
