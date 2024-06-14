class_name CapitalFeature
extends TileFeature

const CAPITAL_TIER_1_PLACEHOLDER = preload("res://sprites/TileFeatures/Capital Tier 1 Placeholder.png")
const CAPITAL_TIER_2_PLACEHOLDER = preload("res://sprites/TileFeatures/Capital Tier 2 Placeholder.png")

var population: int = 5
var population_cap: int = 10

var upgraded := false

func _ready() -> void:
	super()

func initial_texture() -> Resource:
	return CAPITAL_TIER_1_PLACEHOLDER

func production() -> Array[GameResource]:
	return [GameResource.new(Enums.ResourceType.GOLD, population)]

func can_upgrade() -> bool:
	return !upgraded

func upgrade() -> void:
	self.update_texture(CAPITAL_TIER_2_PLACEHOLDER)
	self.population_cap = 20
	self.upgraded = true

func turn_update(turn_num: int) -> void:
	if turn_num % 2 == 0:
		self.population = clamp(population + 1, 1, population_cap)
		Signals.population_changed.emit(self.tile.region)

func upgrade_cost() -> Array[GameResource]:
	return [GameResource.new(Enums.ResourceType.GOLD, 10)]

func capture(captor: Kingdom) -> void:
	# remove the region from the old kingdom
	self.tile.region.kingdom.regions.erase(self.tile.region)
	# mark the new kingdom as the owner of this region
	self.tile.region.kingdom = captor
	# register this region in the new kingdom
	self.tile.region.kingdom.regions.append(self.tile.region)
	# Signal capture to region
	Signals.region_captured.emit(self.tile.region)

func get_actions() -> Array[TileAction]:
	var actions = super()
	# Add attack action
	if tile.region.kingdom != GameManager.player.kingdom:
		actions.append(AttackAction.new(self.tile))
	return actions

func _init() -> void:
	super()

