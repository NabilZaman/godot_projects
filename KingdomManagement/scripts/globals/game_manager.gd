extends Node

const DEFEAT_SCENE = preload("res://scenes/DefeatScene.tscn")
const VICTORY_SCENE = preload("res://scenes/VictoryScene.tscn")

var turn_count: int = 1
var player: Player
var rng := RandomNumberGenerator.new()

var resource_bank: Dictionary = {}

func _ready() -> void:
	start_game()

func start_game() -> void:
	self.player = Player.new()

func set_player_kingdom(kingdom: Kingdom) -> void:
	self.player.kingdom = kingdom

func adjust_player_resource(resource: GameResource) -> void:
	self.player.adjust_resource(resource)
	if resource.type == Enums.ResourceType.GOLD:
		Signals.gold_changed.emit(self.player.get_resource(Enums.ResourceType.GOLD).qty)
	
func consume_action(action_cost: float) -> void:
	self.player.actions -= action_cost
	Signals.actions_changed.emit()
	Signals.close_tile_menu.emit()

# Returns the list of global actions available
func get_actions() -> Array[GlobalAction]:
	return []

func end_turn() -> void:
	Signals.close_tile_menu.emit()
	self.player.refresh_actions()
	self.turn_count += 1
	Signals.turn_changed.emit(self.turn_count)
	collect_resources()
	replenish_troops()
	check_win()
	check_loss()
	# run new turn events

func collect_resources() -> void:
	var resources: Array[GameResource] = []
	if self.player.kingdom != null:
		for region in self.player.kingdom.regions:
			for tile in region.tiles:
				resources.append_array(tile.collect_resources())
	var aggregates = Utilities.aggregate_resources(resources)
	for resource in aggregates:
		self.adjust_player_resource(resource)

func replenish_troops() -> void:
	player.kingdom.army.replenish_pct(.02)

func check_loss():
	if self.turn_count > 20:
		get_tree().change_scene_to_packed(DEFEAT_SCENE)

func check_win():
	if len(player.kingdom.regions) >= 6:
		get_tree().change_scene_to_packed(VICTORY_SCENE)
