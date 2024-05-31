extends PanelContainer

@export var full_texture: Texture2D
@export var empty_texture: Texture2D
@onready var energy_icons: HBoxContainer = $MarginContainer/EnergyIcons


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.actions_changed.connect(update_actions)
	self.update_actions(GameManager.player.actions)

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

func update_actions(num_actions: int) -> void:
	var num_icons = energy_icons.get_child_count() # detect full energy differently
	print("updating %s to %s" % [num_icons, num_actions])
	var num_to_add = num_actions - num_icons
	var num_to_remove = num_icons - num_actions
	for i in range(num_to_add):
		self.add_energy()
	for i in range(num_to_remove):
		self.remove_energy()
	
