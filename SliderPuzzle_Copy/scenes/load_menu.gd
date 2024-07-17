class_name LoadMenu
extends Control


@onready var no_saves_label: Label = %NoSavesLabel
@onready var saves_list: VBoxContainer = %SavesList

var SAVE_ENTRY_SCENE: PackedScene = preload('res://scenes/save_entry_panel.tscn')

signal data_loaded(save_data: SaveData)
signal closed()

func read_save_data() -> Array[SaveData]:
	var save_data: Array[SaveData] = []
	if not DirAccess.dir_exists_absolute(Config.SAVES_FOLDER):
		return save_data
	var save_files: PackedStringArray = DirAccess.get_files_at(Config.SAVES_FOLDER)
	for save_file in save_files:
		save_data.append(load(save_file))
	print(save_data)
	return save_data

func refresh() -> void:
	no_saves_label.show()
	for child in saves_list.get_children():
		if child != no_saves_label:
			child.queue_free()
	print("Freed children...")
	for save_data in read_save_data():
		no_saves_label.hide()
		var save_entry: SaveEntryPanel = SAVE_ENTRY_SCENE.instantiate()
		save_entry.setup(save_data)
		saves_list.add_child(save_entry)
		save_entry.selected.connect(on_load.bind(save_data))

func on_load(save_data: SaveData):
	data_loaded.emit(save_data)

func on_close() -> void:
	closed.emit()
