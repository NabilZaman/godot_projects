class_name StartMenu
extends CanvasLayer

@onready var menu_options: OptionsMenu = %MenuOptions
@onready var load_menu: LoadMenu = %LoadMenu
@onready var difficulty_menu: DifficultyMenu = %DifficultyMenu

var game_builder = GameSetup.new()

func on_new() -> void:
	print("New gaming!")
	menu_options.hide()
	difficulty_menu.show()

func on_continue() -> void:
	menu_options.hide()
	load_menu.refresh()
	load_menu.show()

func close_load_menu() -> void:
	load_menu.hide()
	menu_options.show()

func on_exit() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func start_scene(scene: Node) -> void:
	get_tree().root.add_child(scene)
	self.queue_free()

func load_save(save_data: SaveData) -> void:
	var game := game_builder.setup_from_save(save_data)
	start_scene(game)

func start_with_difficulty(difficulty: Enums.Difficulty) -> void:
	var game := game_builder.setup_from_difficulty(difficulty)
	start_scene(game)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_menu.closed.connect(close_load_menu)
	load_menu.data_loaded.connect(load_save)
	difficulty_menu.difficulty_selected.connect(start_with_difficulty)
