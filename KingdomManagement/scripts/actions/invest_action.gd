class_name InvestAction
extends TileAction


func name() -> String:
	return "INVEST"

func invoke():
	print("Investing!")
	#if available():
		#self.tile.upgrade()
		#GameManager.change_gold(-cost())
	super()

# Indicates whether this action is available
func available() -> bool:
	return GameManager.player.gold >= cost()

func cost() -> int:
	return 10#GameConfig.investment_cost[self.tile.level]

func _init(tile: HexTile):
	super(tile)
