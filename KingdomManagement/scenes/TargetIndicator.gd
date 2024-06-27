class_name TargetIndicator
extends TextureRect

@onready var red_arrows: Resource = preload("res://sprites/Icons/double_arrow_red.png")
@onready var blue_arrows: Resource = preload("res://sprites/Icons/double_arrow_red.png")
@onready var both_arrows: Resource = preload("res://sprites/Icons/double_arrow_both.png")
@onready var arrows: TextureRect = %arrows

func show_red(flip: bool = false) -> void:
	arrows.texture = red_arrows
	if flip:
		arrows.rotation_degrees = 180

func show_blue(flip: bool = false) -> void:
	arrows.texture = blue_arrows
	if flip:
		arrows.rotation_degrees = 180

func show_both(flip: bool = false) -> void:
	arrows.texture = both_arrows
	if flip:
		arrows.rotation_degrees = 180
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
