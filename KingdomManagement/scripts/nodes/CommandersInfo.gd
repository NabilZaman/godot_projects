extends PanelContainer

@onready var value: Label = $MarginContainer/HBoxContainer/Value
var connector: LabelSignalConnector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connector = LabelSignalConnector.new(Signals.commanders_changed, value)
