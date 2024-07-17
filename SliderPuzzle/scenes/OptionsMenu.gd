
class_name OptionsMenu
extends Control

var game_builder = GameSetup.new()

@onready var load_menu: LoadMenu = %LoadMenu
@onready var menu_options: VBoxContainer = %MenuOptions

var game: Game

signal save_selected()
signal load_selected()
signal menu_selected()
signal return_selected()

func set_game(game: Game) -> void:
    self.game = game

func on_save() -> void:
    save_selected.emit()

func on_load() -> void:
    load_selected.emit()
    menu_options.hide()
    load_menu.refresh()
    load_menu.show()

func on_load_close() -> void:
    load_menu.hide()
    menu_options.show()

func load_save(save_data: SaveData) -> void:
    var new_game := game_builder.setup_from_save(save_data)
    start_scene(new_game)

func start_scene(scene: Node) -> void:
    game.queue_free()
    get_tree().root.add_child(scene)

func on_menu_nav() -> void:
    menu_selected.emit()

func on_return() -> void:
    return_selected.emit()

func volume_adjusted(new_value: int) -> void:
    MusicPlayer.set_volume(new_value / 100.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    load_menu.closed.connect(on_load_close)
    load_menu.data_loaded.connect(load_save)
