class_name InvestAction
extends Action

var territory: Territory

func name() -> String:
	return "INVEST"

func invoke():
	print("Investing!")
	if available():
		self.territory.upgrade()
		GameManager.change_gold(-cost())
	super()

# Indicates whether this action is available
func available() -> bool:
	return GameManager.player.gold >= cost()

func cost() -> int:
	return GameConfig.investment_cost[self.territory.level]

func _init(territory: Territory):
	self.territory = territory
