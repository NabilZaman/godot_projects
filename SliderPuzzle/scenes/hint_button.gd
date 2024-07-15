class_name HintButton
extends TextureButton

const READY_TEXT = "HINT"
const NOT_READY_TEXT = "PREPARING HINTS"

@onready var label: Label = %HintLabel

func enable() -> void:
	# enable button
	self.disabled = false
	# highlight the text
	label.self_modulate.a = 1.0
	# change text to ready
	label.text = READY_TEXT

func disable() -> void:
	# enable button
	self.disabled = true
	# highlight the text
	label.self_modulate.a = 0.5
	# change text to ready
	label.text = NOT_READY_TEXT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable()


# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
