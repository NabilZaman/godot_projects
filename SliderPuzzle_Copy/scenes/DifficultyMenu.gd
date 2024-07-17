class_name DifficultyMenu
extends Control

signal difficulty_selected(difficulty: Enums.Difficulty)


func on_classic_select() -> void:
	difficulty_selected.emit(Enums.Difficulty.CLASSIC)

func on_easy_select() -> void:
	difficulty_selected.emit(Enums.Difficulty.EASY)

func on_medium_select() -> void:
	difficulty_selected.emit(Enums.Difficulty.MEDIUM)

func on_hard_select() -> void:
	difficulty_selected.emit(Enums.Difficulty.HARD)

func on_impossible_select() -> void:
	difficulty_selected.emit(Enums.Difficulty.IMPOSSIBLE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

