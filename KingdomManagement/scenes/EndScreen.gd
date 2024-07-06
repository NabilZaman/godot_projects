class_name BattleEndScreen
extends Button

const MENU = preload("res://scenes/StartMenu.tscn")

@onready var win_label: Label = %WinLabel
@onready var lose_label: Label = %LoseLabel

func close_battle() -> void:
	get_tree().change_scene_to_packed(MENU)

func show_win() -> void:
	win_label.show()
	lose_label.hide()
	self.show()

func show_lose() -> void:
	lose_label.show()
	win_label.hide()
	self.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
