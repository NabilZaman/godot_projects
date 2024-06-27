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

signal hovered()
signal unhovered()
signal clicked()
signal ability_choice(ability: CombatAbility)

# TODO:
# represent shields(!)
# represent energy/actions remaining(!)
# represent buffs?

func hover() -> void:
	# print("Got hovered!")
	hovered.emit()

func unhover() -> void:
	# print("Got unhovered!")
	unhovered.emit()

func general_click() -> void:
	clicked.emit()
	# print("Got clicked!")

func ability1() -> void:
	ability_choice.emit(unit.unit_type.basic_ability())

func ability2() -> void:
	ability_choice.emit(unit.unit_type.special_ability())

func ability3() -> void:
	ability_choice.emit(unit.commander.ultimate_ability())

func show_details() -> void:
	if player_controlled:
		print("player!")
		attacks.show()
	else:
		print("Not player!")

func hide_details() -> void:
	attacks.hide()

#TODO: The target indicators need to move to the left if this is not player_controlled
func select(selection_type: Enums.SelectionType) -> void:
	target_indicator.show()
	var flip := not player_controlled # npc units are mirrored
	match selection_type:
		Enums.SelectionType.OUT_HARM: # Invert outgoing arrows, default texture points in from player perspective
			target_indicator.show_red(not flip)
		Enums.SelectionType.OUT_HELP:
			target_indicator.show_blue(not flip)
		Enums.SelectionType.OUT_BOTH:
			target_indicator.show_both(not flip)
		Enums.SelectionType.IN_HARM:
			target_indicator.show_red(flip)
		Enums.SelectionType.IN_HELP:
			target_indicator.show_blue(flip)
		Enums.SelectionType.IN_BOTH:
			target_indicator.show_both(flip)

func unselect() -> void:
	target_indicator.hide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(unit: CombatUnit, player_controlled: bool):
	self.enabled = true
	self.unit = unit
	self.player_controlled = player_controlled
	
	commander_name.text = unit.commander.name
	
	healthbar.max_value = unit.max_troops
	healthbar.value = unit.num_troops
	unit_count.text = "%d / %d" % [unit.num_troops, unit.max_troops]

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
