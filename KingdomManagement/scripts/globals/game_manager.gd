extends Node

var turn_count: int = 0
var player: Player

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
	var dummy = GlobalAction.new()
	return [dummy]

func end_turn() -> void:
	Signals.close_tile_menu.emit()
	self.player.refresh_actions()
	self.turn_count += 1
	Signals.turn_changed.emit(self.turn_count)
	collect_resources()
	replenish_troops()
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
	pass
