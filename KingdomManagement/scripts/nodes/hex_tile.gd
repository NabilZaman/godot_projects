extends Node2D

const hover_elevation = Vector2(0, -20)
@onready var sprite = $Sprite2D

var hovered = false
var territory: Territory = Territory.new("", Enums.TerritoryOwner.NPC)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta: float) -> void:
	#if hovered and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#on_click()
	pass

func set_territory(territory: Territory):
	self.territory = territory

func on_click(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		Signals.open_tile_menu.emit(territory)
		print(self.name + ": You clicked me!")

func _on_mouse_entered():
	sprite.translate(hover_elevation)
	self.hovered = true


func _on_mouse_exited():
	sprite.translate(-1 * hover_elevation)
	self.hovered = false

# 138, 150 | +276
# +138, +203
