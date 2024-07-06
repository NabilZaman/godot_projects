class_name BattleScene
extends CanvasLayer



# Player Units
@onready var player00: CombatUnitView = %playerunit00
@onready var player01: CombatUnitView = %playerunit01
@onready var player02: CombatUnitView = %playerunit02
@onready var player10: CombatUnitView = %playerunit10
@onready var player11: CombatUnitView = %playerunit11
@onready var player12: CombatUnitView = %playerunit12

var player_units: Dictionary = {}

# Enemy Units
@onready var enemy00: CombatUnitView = %enemyunit00
@onready var enemy01: CombatUnitView = %enemyunit01
@onready var enemy02: CombatUnitView = %enemyunit02
@onready var enemy10: CombatUnitView = %enemyunit10
@onready var enemy11: CombatUnitView = %enemyunit11
@onready var enemy12: CombatUnitView = %enemyunit12

var enemy_units: Dictionary = {}

var unit_view_lookup: Dictionary = {}

@onready var morale_bar: TextureProgressBar = %MoraleBar
@onready var turn_value: Label = %TurnsValue


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
	if battle:
		play_intro()

func play_intro() -> void:
	# presumably play some intro animation of lining up units/battle graphics
	player_turn()

func player_turn() -> void:
	# presumably play animation of starting the player turn
	self.state = BattleState.PLAYER_TURN_AWAITING_SELECTION
	battle.advance_turns()

func enemy_turn() -> void:
	# presumably play animation of starting the enemy turn
	self.state = BattleState.ENEMY_TURN
	hide_all_details()
	clear_targets()
	battle.advance_turns()
	# This should eventually use the turn order, not just flip turns
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
	unit.died.connect(on_unit_died.bind(unit))

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

func win() -> void:
	pass

func lose() -> void:
	pass

func check_end_condition() -> void:
	if battle.morale == 0.0:
		lose()
	if battle.morale == 100.0:
		win()
		
func update_morale_display() -> void:
	morale_bar.value = battle.morale

func update_turn_display() -> void:
	turn_value.text = "%d / %d" % [battle.turn_count, battle.turn_limit]

func push_back_row_forward() -> void:
	pass # swap front and back row units then "refresh" the unit

func on_unit_died(unit: CombatUnitView) -> void:
	if unit.unit.battle_pos.row == 1:
		return # No need to do anything if back row unit died
	
	# check if we need to move the back row up
	var team: Dictionary
	if unit.player_controlled:
		team = player_units
	else:
		team = enemy_units
	for pos in team:
		var teammate: CombatUnitView = team[pos]
		if pos.row == 0 and not teammate.is_dead:
			return # found a living front-row unit, nothing to do
	push_back_row_forward()


func exec_action() -> void:
	# Execute the pending action
	pending_combat_action.execute()
	self.pending_combat_action = null

	# update the morale if necessary
	battle.recompute_morale()

	# TODO: deal with dead units
	# TODO: deal with cleared rows (move back row up if front row is cleared)
	# TODO: deal with victory condition

	# This should eventually use the turn order, not just flip turns
	enemy_turn()


func setup(battle: Battle) -> void:
	self.battle = battle
	if state == BattleState.INTRO:
		play_intro()
	battle.morale_changed.connect(update_morale_display)
	battle.morale_changed.connect(check_end_condition)
	battle.turns_changed.connect(update_turn_display)

