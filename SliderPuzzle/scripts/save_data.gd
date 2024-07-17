class_name SaveData
extends Resource

@export var state: GridState
@export var move_count: int
@export var difficulty: Enums.Difficulty
@export var timestamp: String

func _init(state: GridState = null, move_count: int = 0, difficulty: Enums.Difficulty = Enums.Difficulty.CLASSIC) -> void:
    self.state = state
    self.move_count = move_count
    self.difficulty = difficulty
    self.timestamp = Time.get_datetime_string_from_system(false, true)

