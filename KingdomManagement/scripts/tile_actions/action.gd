class_name Action
extends Resource

func name() -> String:
	return "NOTHING"

func energy_cost() -> float:
	return Enums.ActionCost.FULL

func resource_cost() -> Array[GameResource]:
	return []

func invoke() -> void:
	print("Invoking an action!")
	GameManager.consume_action(energy_cost())
	for cost in self.resource_cost():
		cost.qty *= -1
		GameManager.adjust_player_resource(cost)

# Indicates whether this action is available
func available() -> bool:
	return true

func affordable() -> bool:
	for cost in self.resource_cost():
		if not GameManager.player.has_min_resource(cost):
			return false
	return true

func energy_affordable() -> bool:
	return GameManager.player.actions >= self.energy_cost()

func as_button() -> Button:
	var button = Button.new()
	button.text = self.name()
	if not available() or not affordable() or not energy_affordable():
		button.disabled = true
		if not available():
			button.tooltip_text = "%s is not currently available" % self.name()
		elif not self.energy_affordable():
			button.tooltip_text = "You don't have enough energy to %s!" % self.name()
		elif not self.affordable():
			button.tooltip_text = "You don't have enough resources to afford to %s!" % self.name()
	else:
		button.pressed.connect(invoke)
	return button
