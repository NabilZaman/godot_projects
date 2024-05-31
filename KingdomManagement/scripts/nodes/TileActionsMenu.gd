extends PanelContainer

var is_open = false
var actions: Array[Action] = []

@onready var menu_options: VBoxContainer = $MarginContainer/Wrapper/MenuOptions


func on_close() -> void:
	print("Closing menu!")
	if !is_open:
		return # nothing to do
	# clean up children
	self.visible = false
	self.is_open = false
	for child in menu_options.get_children():
		menu_options.remove_child(child)
		child.queue_free()
	actions.clear()

func setup_actions(territory: Territory) -> void:
	# TODO: There should be a difference between what is temporarily unavailable
	# (eg. you can't afford it) vs. what simply doesn't make sense (attacking yourself)
	actions.append(AttackAction.new(territory))
	actions.append(InvestAction.new(territory))

func on_open(territory: Territory) -> void:
	print("Opening menu!")
	if is_open:
		return # nothing to do
	self.visible = true
	self.is_open = true
	# Put the name of the territory at the top
	# display an icon/crest
	# Draw some representation of the level of the territory (small fort vs bustling city)
	# shade the background based on if it's player owned or an enemy (or maybe based on the npc theme)
	# ...
	# populate menu action options
	setup_actions(territory)
	for action in actions:
		if action.available():
			# setup a button with this action
			var action_button = Button.new()
			action_button.text = action.name()
			action_button.pressed.connect(action.invoke)
			menu_options.add_child(action_button)

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.open_tile_menu.connect(on_open)
	Signals.close_tile_menu.connect(on_close)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
