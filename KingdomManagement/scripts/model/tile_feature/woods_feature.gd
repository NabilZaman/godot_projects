class_name WoodsFeature
extends TileFeature

const FOREST_SYMBOL = preload("res://sprites/TileFeatures/Forest Symbol.png")
const LUMBER_MILL_ICON = preload("res://sprites/TileFeatures/Lumber Mill Icon.png")

var output := 1
var upgraded := false

func _ready() -> void:
	super()
	self.feature_sprite.scale = Vector2(0.8,0.8)
	self.feature_sprite.position.y = -10

func initial_texture() -> Resource:
	return FOREST_SYMBOL

func production() -> Array[GameResource]:
	return [GameResource.new(Enums.ResourceType.LUMBER, output)]

func can_upgrade() -> bool:
	return !upgraded

func upgrade() -> void:
	self.update_texture(LUMBER_MILL_ICON)
	self.output = 2
	self.upgraded = true

func upgrade_cost() -> Array[GameResource]:
	return [GameResource.new(Enums.ResourceType.GOLD, 10)]

func _init() -> void:
	super()

