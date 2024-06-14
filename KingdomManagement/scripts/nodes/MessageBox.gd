class_name MessageBox
extends PanelContainer

@onready var confirm_button: Button = $ScrollContainer/MarginContainer/VBoxContainer/HBoxContainer/CONFIRM
@onready var cancel_button: Button = $ScrollContainer/MarginContainer/VBoxContainer/HBoxContainer/CANCEL
@onready var message_body: Label = $ScrollContainer/MarginContainer/VBoxContainer/MessageBody

var min_height: int
var min_width: int
var max_width: int
var message: String
var cancellable: bool


signal user_response(resp: Enums.UserResponse)


func set_message(message: String) -> void:
	# Adjust box dimensions appropriately with text wrap, etc
	self.message_body.text = message

func configure(height: int, width: int, max_width: int, show_cancel: bool, message: String) -> void:
	self.min_height = height
	self.min_width = width
	self.max_width = max_width
	self.cancellable = show_cancel
	self.message = message
	# update box dimensions


func _confirm() -> void:
	user_response.emit(Enums.UserResponse.CONFIRM)

func _cancel() -> void:
	user_response.emit(Enums.UserResponse.CANCEL)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not self.cancellable:
		self.cancel_button.hide()
	self.set_message(message)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
