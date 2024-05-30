extends Camera2D


const SPEED = 1500
const xmove = Vector2(SPEED, 0)
const ymove = Vector2(0, SPEED)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		self.position -= ymove * delta
	if Input.is_action_pressed("ui_down"):
		self.position += ymove * delta
	if Input.is_action_pressed("ui_left"):
		self.position -= xmove * delta
	if Input.is_action_pressed("ui_right"):
		self.position += xmove * delta
