class_name UpgradeAction
extends TileAction


func name() -> String:
	return "UPGRADE"

func invoke():
	print("Upgrading!")
	self.tile.feature.upgrade()
	super()

func resource_cost() -> Array[GameResource]:
	return self.tile.feature.upgrade_cost()

func _init(tile: HexTile):
	assert(tile.feature != null)
	super(tile)
