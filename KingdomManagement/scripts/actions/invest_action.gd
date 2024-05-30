class_name InvestAction
extends Action

var territory: Territory

func invoke():
	print("Investing!")

# Indicates whether this action is available
func available() -> bool:
	return false

func _init(territory: Territory):
	self.territory = territory
