class_name MoveCountBoard
extends Control

@onready var background: TextureRect = %MovesBackground
@onready var thousands_digit: Label = %thousands
@onready var hundreds_digit: Label = %hundreds
@onready var tens_digit: Label = %tens
@onready var ones_digit: Label = %ones
@onready var moves_label: Label = %MovesLabel

@export var move_label_text: String = "Moves"

var four_digit_board: Resource = preload('res://assets/MoveCounter_4digits.png')
var three_digit_board: Resource = preload('res://assets/MoveCounter_3digits.png')
var two_digit_board: Resource = preload('res://assets/MoveCounter_2digits.png')

func update_thousands(move_count: int) -> void:
	thousands_digit.text = str(move_count / 1000)

func update_hundreds(move_count: int) -> void:
	hundreds_digit.text = str((move_count % 1000) / 100)

func update_tens(move_count: int) -> void:
	tens_digit.text = str((move_count % 100) / 10)

func update_ones(move_count: int) -> void:
	ones_digit.text = str(move_count % 10)

func update_moves(move_count: int) -> void:
	var new_background = two_digit_board
	hundreds_digit.hide()
	thousands_digit.hide()
	update_ones(move_count)
	update_tens(move_count)
	if move_count > 99:
		new_background = three_digit_board
		hundreds_digit.show()
		update_hundreds(move_count)
	if move_count > 999:
		new_background = four_digit_board
		thousands_digit.show()
		update_thousands(move_count)
	background.texture = new_background

func _ready() -> void:
	self.moves_label.text = move_label_text
