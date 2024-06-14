extends Node

const DEFEAT_SCENE = preload("res://scenes/DefeatScene.tscn")
const VICTORY_SCENE = preload("res://scenes/VictoryScene.tscn")

var turn_count: int = 1
var player: Player
var rng := RandomNumberGenerator.new()

var resource_bank: Dictionary = {}

const TUTORIAL_MSG = """
Welcome to this very rudimentary demo of my strategy game!

The objective of this demo will be to conquer the available regions on the map
within the turn limit of 20 turns.

On the top right of the screen you'll see your current gold and total troops.
These are the two primary resources you'll work with.

To the left of them are your action points. Every action you take consumes one
action point. In this demo you'll get two actions per turn.

You may end the turn whenever you wish, whether or not you've exhausted your
available actions.

Every turn you'll collect taxes from the regions you control (initally, just the one
region in the Judgement Kingdom) and this will be added to your gold total.
Additionally if you have any injured troops, a small % of them will heal for free each turn.

On the top left of the screen is a button that will bring up your Army menu.
This menu allows you to spend gold to either replenish your injured troops, up to your
maximum, or recruit more troops - increasing your max.

Finally to the crux of the matter: conquering regions. You can select a fort or capital
city outside of your controlled territories to try to attack it. Selecting "ATTACK" will
give you an estimate of your chances to win, and will prompt you to confirm your decision.
Feel free to evaluate your options before comitting.

Once you attack you'll immediately either win or lose based on a random roll. If you win, you
will capture the chosen fort or city! You can't attack an enemy capital until you've captured
all their forts. Once you capture a capital you'll control that region which will supplement your
gold income.

That should be it. Go forth, prosper, and hopefully this will one day have a more interesting and
better balanced gameplay loop.
"""

func _ready() -> void:
	self.player = Player.new()

func start_game() -> void:
	Signals.show_message.emit(TUTORIAL_MSG)

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
