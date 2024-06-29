class_name CombatUnitView
extends Control

var enabled: bool = false

var unit: CombatUnit
var player_controlled: bool
@onready var unitbox: Node = %UnitBox
@onready var attacks: Node = %Attacks
@onready var attack1: Button = %Attacks/attack1
@onready var attack2: Button = %Attacks/attack2
@onready var attack3: Button = %Attacks/attack3
@onready var commander_name: Label = %CommanderName
@onready var healthbar: TextureProgressBar = %HealthBar
@onready var unit_count: Label = %UnitCount
@onready var target_indicator: TargetIndicator = %TargetIndicator

# signals up to battle scene
signal hovered()
signal unhovered()
signal clicked()
signal ability_choice(ability: CombatAbility)

# TODO:
# represent shields(!)
# represent energy/actions remaining(!)
# represent buffs?

func hover() -> void:
	hovered.emit()

func unhover() -> void:
	unhovered.emit()

func general_click() -> void:
	clicked.emit()

func ability1() -> void:
	ability_choice.emit(unit.unit_type.basic_ability())

func ability2() -> void:
	ability_choice.emit(unit.unit_type.special_ability())

func ability3() -> void:
	ability_choice.emit(unit.commander.ultimate_ability())

func show_details() -> void:
	if player_controlled:
		attacks.show()

func hide_details() -> void:
	attacks.hide()

func select(selection_type: Enums.SelectionType) -> void:
	target_indicator.show()
	match selection_type:
		Enums.SelectionType.IN_HARM:
			target_indicator.show_red()
		Enums.SelectionType.IN_HELP:
			target_indicator.show_blue()
		Enums.SelectionType.IN_BOTH:
			target_indicator.show_mixed()

func unselect() -> void:
	target_indicator.hide()

func update_troops_display() -> void:
	print("UPdating troops!")
	healthbar.value = unit.num_troops
	unit_count.text = "%d / %d" % [unit.num_troops, unit.max_troops]

func update_shields_display() -> void:
	pass # TODO: Display and updae shields

func update_actions_display() -> void:
	pass # TODO: Display and updae actions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# TODO: Turn count is being presented
func setup(unit: CombatUnit, player_controlled: bool):
	self.enabled = true
	self.unit = unit
	self.player_controlled = player_controlled
	
	commander_name.text = unit.commander.name
	
	healthbar.max_value = unit.max_troops
	update_troops_display()

	unit.troops_changed.connect(update_troops_display)
	unit.shields_changed.connect(update_shields_display)
	unit.actions_changed.connect(update_actions_display)

	if unit.unit_type.basic_ability() == null:
		attack1.hide()
	else:
		attack1.text = unit.unit_type.basic_ability().name()
	if unit.unit_type.special_ability() == null:
		attack2.hide()
	else:
		attack2.text = unit.unit_type.special_ability().name()
	if unit.commander.ultimate_ability() == null:
		attack3.hide()
	else:
		attack3.text = unit.commander.ultimate_ability().name()

	unitbox.show()
	


# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
