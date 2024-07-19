class_name PlayerBlackHole
extends Sprite2D


func warp_background_vector(pos: Vector2) -> Vector2:
	
	return Vector2()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.position = event.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
