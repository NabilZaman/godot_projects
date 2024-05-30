
extends Node2D

const hover_elevation = Vector2(0, -20)
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_mouse_entered():
	sprite.translate(hover_elevation)
	#print(self.name +": I see a mouse!")


func _on_mouse_exited():
	sprite.translate(-1 * hover_elevation)

# 138, 150 | +276
# +138, +203
