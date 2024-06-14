extends PanelContainer

@onready var value: Label = $MarginContainer/HBoxContainer/Value

func _on_update(army: Army) -> void:
	value.text = "%s/%s" % [army.troop_count, army.max_troops]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.troops_changed.connect(_on_update)
	_on_update(GameManager.player.kingdom.army)
