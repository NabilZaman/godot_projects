class_name TileFeature
extends Node2D

const TILE_FEATURE_RING = preload("res://sprites/TileFeatures/Tile Feature Ring.png")
var ring_sprite: Sprite2D

var feature_sprite: Sprite2D

var tile: HexTile

func _ready() -> void:
	self.ring_sprite = Sprite2D.new()
	ring_sprite.texture = TILE_FEATURE_RING
	ring_sprite.hide()
	ring_sprite.position.y = 25
	self.add_child(ring_sprite)
	
	if self.initial_texture() != null:
		self.feature_sprite = Sprite2D.new()
		self.feature_sprite.texture = self.initial_texture()
		self.add_child(feature_sprite)
	
	Signals.turn_changed.connect(turn_update)

func focus() -> void:
	ring_sprite.show()

func unfocus() -> void:
	ring_sprite.hide()

func set_tile(tile: HexTile) -> void:
	self.tile = tile

func update_texture(new_texture: Resource) -> void:
	self.feature_sprite.texture = new_texture

func initial_texture() -> Resource:
	return null

func turn_update(turn_num: int) -> void:
	pass

func production() -> Array[GameResource]:
	return []

func can_upgrade() -> bool:
	return false

func upgrade() -> void:
	pass

func upgrade_cost() -> Array[GameResource]:
	return []

func get_actions() -> Array[TileAction]:
	# Add upgrade action
	var actions: Array[TileAction] = []
	if self.tile.region.kingdom == GameManager.player.kingdom and self.can_upgrade():
		actions.append(UpgradeAction.new(self.tile))
	return actions

func _init() -> void:
	pass
