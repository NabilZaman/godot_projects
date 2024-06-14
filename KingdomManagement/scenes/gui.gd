extends CanvasLayer

const MESSAGE_BOX = preload("res://scenes/message_box.tscn")
const ARMY_MENU = preload("res://scenes/army_menu.tscn")

@onready var blocker: Control = $Blocker

# Currently we don't control that you can't show a new message until the current one has finished
var cur_message: MessageBox
var army_menu: ArmyMenu

func _ready() -> void:
	Signals.show_message.connect(show_message)
	Signals.get_confirmation.connect(get_confirmation)
	Signals.open_army_menu.connect(_on_army_button)
	Signals.close_army_menu.connect(on_army_menu_close)

func block_inputs() -> void:
	blocker.show()

func unblock_inputs() -> void:
	blocker.hide()

func create_message_box(cancellable: bool, message: String) -> void:
	close_message_box()
	block_inputs()
	self.cur_message = MESSAGE_BOX.instantiate()
	cur_message.configure(200, 500, 900, cancellable, message)
	self.add_child(cur_message)

func close_message_box() -> void:
	unblock_inputs()
	if self.cur_message != null:
		self.cur_message.queue_free()

func show_message(message: String) -> void:
	print(message)
	create_message_box(false, message)
	await cur_message.user_response
	Signals.user_response.emit(Enums.UserResponse.CONFIRM)
	close_message_box()

func get_confirmation(message: String) -> bool:
	create_message_box(true, message)
	var resp: bool = await cur_message.user_response
	close_message_box()
	Signals.user_response.emit(resp)
	return resp

func _on_army_button() -> void:
	print("HELLO!!")
	if army_menu == null:
		# Open Army Menu
		self.army_menu = ARMY_MENU.instantiate()
		self.add_child(army_menu)
		block_inputs()

func on_army_menu_close() -> void:
	if army_menu != null:
		self.army_menu.queue_free()
		unblock_inputs()
