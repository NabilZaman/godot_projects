extends PanelContainer

@export var full_texture: Texture2D
@export var empty_texture: Texture2D
@export var half_texture: Texture2D
@onready var energy_icons: HBoxContainer = $MarginContainer/EnergyIcons


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.actions_changed.connect(update_actions)
	self.update_actions()

func clear_energy() -> void:
	for child in energy_icons.get_children():
		child.queue_free()

func add_icon(texture: Texture2D) -> void:
	var node = TextureRect.new()
	node.texture = texture
	node.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	energy_icons.add_child(node)

func add_energy() -> void:
	print("Adding energy!")
	var node = TextureRect.new()
	node.texture = full_texture
	node.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	energy_icons.add_child(node)
	
func remove_energy() -> void:
	print("Removing energy!")
	energy_icons.remove_child(energy_icons.get_child(0))
	var node = TextureRect.new()
	node.texture = empty_texture
	node.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	energy_icons.add_child(node)

func update_actions() -> void:
	var max_actions = GameManager.player.max_actions
	var actions_left = GameManager.player.actions
	print("updating actions to %s" % [actions_left])
	self.clear_energy()
	var full_bars = int(actions_left)
	for i in range(full_bars):
		self.add_icon(full_texture)
	if actions_left > full_bars:
		self.add_icon(half_texture)
	var empty_bars = max_actions - ceil(actions_left)
	for i in range(empty_bars):
		self.add_icon(empty_texture)
	
	
	
