extends Camera2D

# PANNING CONFIG
const SPEED := 1500
const xmove := Vector2(SPEED, 0)
const ymove := Vector2(0, SPEED)

# ZOOM CONFIG
const MIN_ZOOM := 0.33
const MAX_ZOOM := 1.4
var zoom_lvl := 1.2
var zoom_factor := 0.1
var zoom_duration := 0.2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func do_zoom(new_zoom: float) -> void:
	self.zoom_lvl = clampf(new_zoom, MIN_ZOOM, MAX_ZOOM)
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(zoom_lvl, zoom_lvl), zoom_duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		self.position -= ymove * delta / zoom_lvl
	if Input.is_action_pressed("ui_down"):
		self.position += ymove * delta / zoom_lvl
	if Input.is_action_pressed("ui_left"):
		self.position -= xmove * delta / zoom_lvl
	if Input.is_action_pressed("ui_right"):
		self.position += xmove * delta / zoom_lvl
	if Input.is_action_just_released("scroll_up"):
		do_zoom(zoom_lvl + zoom_factor)
	if Input.is_action_just_released("scroll_down"):
		do_zoom(zoom_lvl - zoom_factor)

