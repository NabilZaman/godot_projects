class_name BattleScene
extends CanvasLayer

# Player Units
@onready var player00 = %playerunit00
@onready var player01 = %playerunit01
@onready var player02 = %playerunit02
@onready var player10 = %playerunit10
@onready var player11 = %playerunit11
@onready var player12 = %playerunit12

var player_units: Dictionary = {}

# Enemy Units
@onready var enemy00 = %enemyunit00
@onready var enemy01 = %enemyunit01
@onready var enemy02 = %enemyunit02
@onready var enemy10 = %enemyunit10
@onready var enemy11 = %enemyunit11
@onready var enemy12 = %enemyunit12

var enemy_units: Dictionary = {}

var unit_view_lookup: Dictionary = {}

# These states are used to determine how inputs should be treated
enum BattleState {
	INTRO,
	PLAYER_TURN_AWAITING_SELECTION,
	PLAYER_TURN_AWAITING_TARGET,
	ENEMY_TURN,
}

var state: BattleState = BattleState.INTRO
var battle: Battle
var pending_combat_action: CombatAction

func _ready() -> void:
	setup_units()
	play_intro()

func play_intro() -> void:
	# presumably play some intro animation of lining up units/battle graphics
	player_turn()

func player_turn() -> void:
	# presumably play animation of starting the player turn
	self.state = BattleState.PLAYER_TURN_AWAITING_SELECTION

func enemy_turn() -> void:
	# presumably play animation of starting the enemy turn
	self.state = BattleState.ENEMY_TURN
	hide_all_details()
	clear_targets()
	player_turn()

func setup_npc_units(units: Array[CombatUnit]) -> void:
	# NPC units go on the right
	for unit in units:
		var unit_view: CombatUnitView = enemy_units[unit.battle_pos.as_array()]
		unit_view.setup(unit, false)
		hookup_unit_signals(unit_view)
		unit_view_lookup[unit] = unit_view

func setup_player_units(units: Array[CombatUnit]) -> void:
	# Player units go on the left
	for unit in units:
		var unit_view: CombatUnitView = player_units[unit.battle_pos.as_array()]
		unit_view.setup(unit, true)
		hookup_unit_signals(unit_view)
		unit_view_lookup[unit] = unit_view

func setup_units() -> void:
	var player_role: Enums.Role
	var enemy_role: Enums.Role

	if battle.player_attacking:
		player_role = Enums.Role.ATTACKERS
		enemy_role = Enums.Role.DEFENDERS
	else:
		enemy_role = Enums.Role.ATTACKERS
		player_role = Enums.Role.DEFENDERS

	enemy_units[[enemy_role, 0, 0]] = enemy00
	enemy_units[[enemy_role, 0, 1]] = enemy01
	enemy_units[[enemy_role, 0, 2]] = enemy02
	enemy_units[[enemy_role, 1, 0]] = enemy10
	enemy_units[[enemy_role, 1, 1]] = enemy11
	enemy_units[[enemy_role, 1, 2]] = enemy12

	player_units[[player_role, 0, 0]] = player00
	player_units[[player_role, 0, 1]] = player01
	player_units[[player_role, 0, 2]] = player02
	player_units[[player_role, 1, 0]] = player10
	player_units[[player_role, 1, 1]] = player11
	player_units[[player_role, 1, 2]] = player12

	if battle.player_attacking:
		setup_player_units(battle.attackers)
		setup_npc_units(battle.defenders)
	else:
		setup_player_units(battle.defenders)
		setup_npc_units(battle.attackers)

func hookup_unit_signals(unit: CombatUnitView) -> void:
	unit.hovered.connect(on_unit_hover.bind(unit))
	unit.unhovered.connect(on_unit_unhover.bind(unit))
	unit.clicked.connect(on_unit_click.bind(unit))
	unit.ability_choice.connect(on_unit_ability.bind(unit))

func on_unit_hover(unit: CombatUnitView) -> void:
	print("%s got hovered!" % unit, state)
	if state == BattleState.PLAYER_TURN_AWAITING_SELECTION:
		unit.show_details()
	elif state == BattleState.PLAYER_TURN_AWAITING_TARGET and pending_combat_action.is_valid_target(unit.unit.battle_pos):
		pending_combat_action.target = unit.unit
		var impacted_units = pending_combat_action.find_impacted_units()
		var harmed_units = impacted_units[0].keys()
		var helped_units = impacted_units[1].keys()
		var mixed_units = impacted_units[2].keys()

		for harmed_unit in harmed_units:
			unit_view_lookup[harmed_unit].select(Enums.SelectionType.IN_HARM)
		for helped_unit in helped_units:
			unit_view_lookup[helped_unit].select(Enums.SelectionType.IN_HELP)
		for mixed_unit in mixed_units:
			unit_view_lookup[mixed_unit].select(Enums.SelectionType.IN_BOTH)


func on_unit_unhover(unit: CombatUnitView) -> void:
	if state == BattleState.PLAYER_TURN_AWAITING_SELECTION:
		unit.hide_details()
	elif state == BattleState.PLAYER_TURN_AWAITING_TARGET:
		clear_targets()


func clear_targets() -> void:
	if pending_combat_action != null:
		pending_combat_action.target = null
	for unit_view in unit_view_lookup.values():
		unit_view.unselect()

func hide_all_details() -> void:
	for unit_view in unit_view_lookup.values():
		unit_view.hide_details()

func on_unit_click(unit: CombatUnitView) -> void:
	print("%s got clicked!" % unit)
	# If we're not waiting on a target selection
	if state != BattleState.PLAYER_TURN_AWAITING_TARGET:
		return
	# if it isn't a valid target, cancel the action... this would be better to just be on any click? or just on like an esc press
	if not pending_combat_action.is_valid_target(unit.unit.battle_pos):
		pending_combat_action = null
		hide_all_details()
		self.state = BattleState.PLAYER_TURN_AWAITING_SELECTION
		return

	self.pending_combat_action.target = unit.unit
	print("%s is the target!" % unit)
	exec_action()


func on_unit_ability(ability: CombatAbility, unit: CombatUnitView) -> void:
	print("%s got an ability %s clicked!" % [unit, ability])
	if state != BattleState.PLAYER_TURN_AWAITING_SELECTION:
		return
	self.pending_combat_action = CombatAction.new(battle, unit.unit, ability)
	self.state = BattleState.PLAYER_TURN_AWAITING_TARGET


func exec_action() -> void:
	pending_combat_action.execute()
	self.pending_combat_action = null
	enemy_turn()


func setup(battle: Battle) -> void:
	self.battle = battle

