class_name LoadMenu
extends Control


@onready var no_saves_label: Label = %NoSavesLabel
@onready var saves_list: VBoxContainer = %SavesList

var SAVE_ENTRY_SCENE: PackedScene = preload('res://scenes/save_entry_panel.tscn')

signal data_loaded(save_data: SaveData)
signal closed()

func read_save_data(save_path) -> SaveData:
	return load(save_path)

func read_save_files() -> Array[String]:
	var paths: Array[String] = []
	if not DirAccess.dir_exists_absolute(Config.SAVES_FOLDER):
		return paths
	var save_files: PackedStringArray = DirAccess.get_files_at(Config.SAVES_FOLDER)
	for save_file in save_files:
		var save_path := '%s/%s' % [Config.SAVES_FOLDER, save_file]
		paths.append(save_path)
	return paths

func refresh() -> void:
	no_saves_label.show()
	for child in saves_list.get_children():
		if child != no_saves_label:
			child.queue_free()
	for save_file in read_save_files():
		var save_data := read_save_data(save_file)
		no_saves_label.hide()
		var save_entry: SaveEntryPanel = SAVE_ENTRY_SCENE.instantiate()
		save_entry.setup(save_data)
		saves_list.add_child(save_entry)
		save_entry.selected.connect(on_load.bind(save_data))
		save_entry.deleted.connect(on_delete.bind(save_file))

func on_load(save_data: SaveData):
	data_loaded.emit(save_data)

func on_delete(save_path: String) -> void:
	DirAccess.remove_absolute(save_path)
	refresh()

func on_close() -> void:
	closed.emit()
