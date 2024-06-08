extends Node2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var delay: float

func _ready() -> void:
	await get_tree().create_timer(delay).timeout
	animation_player.play('wave_motion')

func setup_animation(delay: float) -> void:
	self.delay = delay

#func run_animation() -> void:
	#print("Running animation!")
	#animation_player.play('wave_motion')
