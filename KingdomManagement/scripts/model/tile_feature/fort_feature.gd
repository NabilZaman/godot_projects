class_name FortFeature
extends TileFeature

const FORT_ICON = preload("res://sprites/TileFeatures/Fort Icon.png")
const UPGRADED_FORT = preload("res://sprites/TileFeatures/Upgraded Fort.png")

var controller: Kingdom

var upgraded := false

func initial_texture() -> Resource:
	return FORT_ICON

func set_tile(tile: HexTile) -> void:
	super(tile)
	self.controller = tile.region.kingdom

func production() -> Array[GameResource]:
	return []

func can_upgrade() -> bool:
	return !upgraded

func upgrade() -> void:
	self.update_texture(UPGRADED_FORT)
	self.upgraded = true

func upgrade_cost() -> Array[GameResource]:
	return [GameResource.new(Enums.ResourceType.GOLD, 10)]

func capture(captor: Kingdom) -> void:
	self.controller = captor

func get_actions() -> Array[TileAction]:
	var actions = super()
	# Add attack action
	if controller != GameManager.player.kingdom:
		actions.append(AttackAction.new(self.tile))
	return actions

func _init() -> void:
	super()

