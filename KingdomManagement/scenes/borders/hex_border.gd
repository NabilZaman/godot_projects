class_name HexBorder
extends Node2D

@onready var border_1: Sprite2D = $border1
@onready var border_2: Sprite2D = $border2
@onready var border_3: Sprite2D = $border3
@onready var border_4: Sprite2D = $border4
@onready var border_5: Sprite2D = $border5
@onready var border_6: Sprite2D = $border6

var segment_sprites: Array[Sprite2D]

func _ready() -> void:
	segment_sprites = [
		border_1,
		border_2,
		border_3,
		border_4,
		border_5,
		border_6,
	]

func set_segment(segment_id: int, value: float) -> void:
	var border_segment = segment_sprites[segment_id]
	if value > 0:
		border_segment.visible = true
		border_segment.modulate.a = value
	else:
		border_segment.visible = false
