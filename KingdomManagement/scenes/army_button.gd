extends Button


func _on_pressed() -> void:
	Signals.open_army_menu.emit()
