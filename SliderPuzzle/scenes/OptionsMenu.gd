class_name OptionsMenu
extends Control

var MAIN_MENU_SCENE: PackedScene = preload('res://scenes/StartMenu.tscn')
var GAME_SCENE: PackedScene = preload('res://scenes/game.tscn')

var game_builder = GameSetup.new()

@onready var load_menu: LoadMenu = %LoadMenu
@onready var menu_options: VBoxContainer = %MenuOptions

signal save_selected()
signal load_selected()
signal menu_selected()
signal return_selected()

func on_save() -> void:
	save_selected.emit()
	# do save

func on_load() -> void:
	load_selected.emit()
	menu_options.hide()
	load_menu.refresh()
	print("Showing load menu")
	load_menu.show()

func on_load_close() -> void:
	load_menu.hide()
	menu_options.show()

func load_save(save_data: SaveData) -> void:
	var game := game_builder.setup_from_save(save_data)
	start_scene(game)

func start_scene(scene: Node) -> void:
	get_node("/root/Game").queue_free()
	get_tree().root.add_child(scene)

func on_menu_nav() -> void:
	var main_menu: StartMenu = MAIN_MENU_SCENE.instantiate()
	start_scene(main_menu)

func on_return() -> void:
	return_selected.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_menu.closed.connect(on_load_close)
	load_menu.data_loaded.connect(load_save)
