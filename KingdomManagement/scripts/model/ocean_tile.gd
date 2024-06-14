class_name OceanTile
extends TileType

const ROLLING_WAVE = preload("res://scenes/rolling_wave.tscn")

const WAVE_X_RANGE = 40

func embelishments() -> Array[Node2D]:
	var WAVE_Y_POSITIONS = range(-70, 70, 30)
	var result: Array[Node2D] = []
	for i in range(3):
		var wave = ROLLING_WAVE.instantiate()
		var xpos = GameManager.rng.randf_range(-WAVE_X_RANGE, WAVE_X_RANGE)
		var ypos_indx = GameManager.rng.randi_range(0, len(WAVE_Y_POSITIONS)-1)
		var ypos = WAVE_Y_POSITIONS[ypos_indx]
		var motion_delay = GameManager.rng.randf() * 3
		wave.setup_animation(motion_delay)
		WAVE_Y_POSITIONS.remove_at(ypos_indx)
		wave.position = Vector2(xpos, ypos)
		wave.z_index = 1
		result.append(wave)
	return result

