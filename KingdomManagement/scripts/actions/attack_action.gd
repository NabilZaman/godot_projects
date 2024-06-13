class_name AttackAction
extends TileAction

func name() -> String:
	return "ATTACK"

func invoke():
	print("Attacking!")
	super()

func _init(tile: HexTile):
	assert(tile.feature != null)
	super(tile)
