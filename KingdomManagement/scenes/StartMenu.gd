extends Node2D

const GAME = preload("res://scenes/game.tscn")

func start_game() -> void:
	get_tree().change_scene_to_packed(GAME)

func quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

