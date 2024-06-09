extends PanelContainer

var is_open = false
var actions: Array[Action] = []

@onready var menu_options: VBoxContainer = $MarginContainer/Wrapper/MenuOptions
@onready var global_options: VBoxContainer = $MarginContainer/Wrapper/GlobalOptions
@onready var region_options: VBoxContainer = $MarginContainer/Wrapper/RegionOptions
@onready var tile_options: VBoxContainer = $MarginContainer/Wrapper/TileOptions


func on_close() -> void:
	if !is_open:
		return # nothing to do
	# clean up children
	self.visible = false
	self.is_open = false
	for submenu in menu_options.get_children():
		for child in submenu.get_children():
			submenu.remove_child(child)
			child.queue_free()
	actions.clear()

func on_open(tile: HexTile) -> void:
	if is_open:
		return # nothing to do	
	self.visible = true
	self.is_open = true
	# Put the name of the region and kingdom at the top
	# "X Region
	# In the
	# Kingdom of Y"
	# display an icon/crest
	# Draw some representation of the level of the region (small fort vs bustling city)
	# shade the background based on if it's player owned or an enemy (or maybe based on the npc theme)
	# ...
	# populate menu action options
	
	for action in GameManager.get_actions():
		global_options.add_child(action.as_button())
	
	for action in tile.region.get_actions():
		region_options.add_child(action.as_button())
	
	for action in tile.get_actions():
		tile_options.add_child(action.as_button())

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.open_tile_menu.connect(on_open)
	Signals.close_tile_menu.connect(on_close)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
