class_name TargetIndicator
extends TextureRect

@onready var red_arrows: Resource = preload("res://sprites/Icons/double_arrow_red.png")
@onready var blue_arrows: Resource = preload("res://sprites/Icons/double_arrow_blue.png")
@onready var mixed_arrows: Resource = preload("res://sprites/Icons/double_arrow_mixed.png")
@onready var arrows: TextureRect = %arrows

func show_red(flip: bool = false) -> void:
	arrows.texture = red_arrows

func show_blue(flip: bool = false) -> void:
	arrows.texture = blue_arrows

func show_mixed(flip: bool = false) -> void:
	arrows.texture = mixed_arrows

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
