class_name AttackAction
extends TileAction

func name() -> String:
	return "ATTACK"

func invoke() -> void:
	super()

# Indicates whether this action is available
func available() -> bool:
	#print("attackable?" + str(self.territory.owner != Enums.TerritoryOwner.PLAYER))
	# TODO: This also needs to check if this terrritory is adjacent to a player tile...
	# also it might be possible to attack yourself if any of the contained settlements are captured by another player
	return true #self.territory.owner != Enums.TerritoryOwner.PLAYER

func _init(tile: HexTile):
	super(tile)
