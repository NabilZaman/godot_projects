@tool
extends PanelContainer

@export var labelNode: Node
@export var value: String

@onready var container = $HBoxContainer
@onready var valueNode = $HBoxContainer/Value


# Called when the node enters the scene tree for the first time.
func _ready():
	container.remove_child(valueNode)
	if labelNode != null:
		var labelParent = labelNode.get_parent()
		if labelParent != null:
			labelParent.remove_child(labelNode)
		container.add_child(labelNode)
	container.add_child(valueNode)
	valueNode.text = value
	


