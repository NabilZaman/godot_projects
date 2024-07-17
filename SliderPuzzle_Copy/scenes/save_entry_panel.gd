class_name SaveEntryPanel
extends Panel

@onready var difficulty_label: Label = %Difficulty
@onready var move_count_label: Label = %MoveCount
@onready var timestamp_label: Label = %Timestamp

var save_data: SaveData

signal selected()
signal deleted()

func on_select() -> void:
	selected.emit()

func on_delete() -> void:
	deleted.emit()

func set_move_count(count: int) -> void:
	move_count_label.text = "Move %d" % count

func set_difficulty(difficulty: Enums.Difficulty) -> void:
	difficulty_label.text = Enums.Difficulty.find_key(difficulty)

func set_timestamp(timestamp: String) -> void:
	timestamp_label.text = timestamp

func setup(save_data: SaveData):
	self.save_data = save_data

func _ready():
	set_move_count(save_data.move_count)
	set_difficulty(save_data.difficulty)
	set_timestamp(save_data.timestamp)

