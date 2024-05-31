class_name Territory
extends Resource

var name: String
var owner: Enums.TerritoryOwner
var level: Enums.TerritoryLevel = Enums.TerritoryLevel.FORT

# TODO: This doesn't support the same kind of sequential conquerying a territory as Rance...
# feels like we need to model this differently

# Upgrades this territory by one level
func upgrade() -> void:
	self.level += 1 # as enums are just ints, we can just add one (probably)


func _init(name: String, owner: Enums.TerritoryOwner):
	self.name = name
	self.owner = owner
