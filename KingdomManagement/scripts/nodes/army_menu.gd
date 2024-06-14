class_name ArmyMenu
extends PanelContainer

## Replenishment
const REPLENISH_PER_GOLD = 8
@onready var replenishment_slider: HSlider = $MarginContainer/VBoxContainer/Replenishment/ReplenishmentSlider
@onready var replen_troops_count: Label = $MarginContainer/VBoxContainer/Replenishment/HBoxContainer/Troops/TroopsCount/MarginContainer/Label
@onready var replen_troops_cost: Label = $MarginContainer/VBoxContainer/Replenishment/HBoxContainer/Cost/CostCount/MarginContainer/Label

func setup_replenish_slider() -> void:
	replenishment_slider.min_value = 0
	replenishment_slider.step = 1
	var troops_missing := player_army.max_troops - player_army.troop_count
	var max_cost: int = troops_missing / REPLENISH_PER_GOLD
	print(min(max_cost, player_gold))
	replenishment_slider.max_value = min(max_cost, player_gold)

func on_replenish_change(value: float) -> void:
	var troops_to_replen := value * REPLENISH_PER_GOLD
	replen_troops_count.text = str(troops_to_replen)
	replen_troops_cost.text = str(value)

func on_replenish_confirm() -> void:
	var value = replenishment_slider.value
	var troops_to_replen = value * REPLENISH_PER_GOLD
	GameManager.adjust_player_resource(GameResource.new(Enums.ResourceType.GOLD, -value))
	player_army.replenish(troops_to_replen)
	setup_sliders()
##

## Recruitment
const RECRUIT_PER_GOLD = 2
@onready var recruitment_slider: HSlider = $MarginContainer/VBoxContainer/Recruitment/RecruitmentSlider
@onready var recruit_troops_count: Label = $MarginContainer/VBoxContainer/Recruitment/HBoxContainer/Troops/TroopsCount/MarginContainer/Label
@onready var recruit_troops_cost: Label = $MarginContainer/VBoxContainer/Recruitment/HBoxContainer/Cost/CostCount/MarginContainer/Label

func setup_recruit_slider() -> void:
	recruitment_slider.min_value = 0
	recruitment_slider.step = 1
	recruitment_slider.max_value = player_gold

func on_recruit_change(value: float) -> void:
	var troops_to_recruit := value * RECRUIT_PER_GOLD
	recruit_troops_count.text = str(troops_to_recruit)
	recruit_troops_cost.text = str(value)

func on_recruit_confirm() -> void:
	var value = recruitment_slider.value
	var troops_to_recruit = value * RECRUIT_PER_GOLD
	GameManager.adjust_player_resource(GameResource.new(Enums.ResourceType.GOLD, -value))
	player_army.recruit(troops_to_recruit)
	setup_sliders()
##

var player_army: Army:
	get:
		return GameManager.player.kingdom.army

var player_gold: int:
	get:
		return GameManager.player.get_resource(Enums.ResourceType.GOLD).qty

func on_close() -> void:
	Signals.close_army_menu.emit()

func setup_sliders() -> void:
	setup_replenish_slider()
	setup_recruit_slider()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_sliders()
	replenishment_slider.value_changed.connect(on_replenish_change)
	recruitment_slider.value_changed.connect(on_recruit_change)
