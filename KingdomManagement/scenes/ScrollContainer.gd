extends ScrollContainer

@export var max_height: int = 500

@onready var message_body: Label = $MarginContainer/VBoxContainer/MessageBody



func on_text_update() -> void:
	if message_body != null:
		self.custom_minimum_size = Vector2(0, min(message_body.size.y, max_height))
