class_name Action
extends Resource

func name() -> String:
	return "NOTHING"

func energy_cost() -> float:
	return Enums.ActionCost.FULL

func invoke() -> void:
	GameManager.consume_action(energy_cost())
	Signals.close_tile_menu.emit()

# Indicates whether this action is available
func available() -> bool:
	return false

func as_button() -> Button:
	var button = Button.new()
	button.text = self.name()
	button.pressed.connect(self.invoke)
	return button

