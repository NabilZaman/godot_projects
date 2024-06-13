extends PanelContainer

var is_open = false
var focused_tile: HexTile

@onready var menu_options: VBoxContainer = $MarginContainer/Layout/MenuOptions
@onready var global_options: VBoxContainer = $MarginContainer/Layout/MenuOptions/GlobalOptions
@onready var region_options: VBoxContainer = $MarginContainer/Layout/MenuOptions/RegionOptions
@onready var tile_options: VBoxContainer = $MarginContainer/Layout/MenuOptions/TileOptions
@onready var region_label: Label = $MarginContainer/Layout/RegionLabel
@onready var kingdom_label: Label = $"MarginContainer/Layout/Kingdom Label"

var cur_actions: Array[Action] = []

func on_close() -> void:
	if !is_open:
		return # nothing to do
	self.visible = false
	self.is_open = false

func clear_menu() -> void:
	for submenu in menu_options.get_children():
		for child in submenu.get_children():
			submenu.remove_child(child)
			child.queue_free()
	cur_actions.clear()
	

func on_open(tile: HexTile) -> void:
	if is_open and focused_tile == tile:
		return # nothing to do
	clear_menu()
	self.visible = true
	self.is_open = true
	self.focused_tile = tile
	self.region_label.text = tile.region.region_name
	self.kingdom_label.text = tile.region.kingdom.kingdom_name

	# display an icon/crest
	# Draw some representation of the level of the region (small fort vs bustling city)
	# shade the background based on if it's player owned or an enemy (or maybe based on the npc theme)
	# ...
	# populate menu action options
	
	for action in GameManager.get_actions():
		cur_actions.append(action)
		global_options.add_child(action.as_button())
	
	for action in tile.region.get_actions():
		cur_actions.append(action)
		region_options.add_child(action.as_button())
	
	for action in tile.get_actions():
		cur_actions.append(action)
		tile_options.add_child(action.as_button())


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.open_tile_menu.connect(on_open)
	Signals.close_tile_menu.connect(on_close)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
