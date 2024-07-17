class_name TextReader
extends Node

signal character_pressed(_char: String)

var letters = "abcdefghijklmnopqrstuvwxyz".split()

func _input(event: InputEvent) -> void:
    if event.is_released():
        var key_press = event.as_text().to_lower()
        if key_press in letters:
            character_pressed.emit(key_press)

