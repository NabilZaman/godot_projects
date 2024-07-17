class_name GameSetup
extends RefCounted

var rng = RandomNumberGenerator.new()
var path_finder: AllPathFinder = preload(Config.SOLUTIONS_RESOURCE_PATH)

var GAME_SCENE: PackedScene = preload('res://scenes/game.tscn')

func setup_from_save(save_data: SaveData) -> Game:
	var new_game: Game = GAME_SCENE.instantiate()
	new_game.load_save_data(save_data)
	return new_game

func setup_from_difficulty(difficulty: Enums.Difficulty) -> Game:
	var new_game: Game = GAME_SCENE.instantiate()
	var game_state: GridState
	if difficulty == Enums.Difficulty.CLASSIC:
		game_state = GridState.from_array(Config.INITIAL_TILE_POSITIONS)
	else:
		var path_len := choose_path_len_from_difficulty(difficulty)
		game_state = path_finder.get_random_state_n_steps_away(path_len)
	new_game.setup(TileGrid.from_state(game_state), 0, difficulty)
	return new_game

func choose_path_len_from_difficulty(difficulty: Enums.Difficulty) -> int:
	match difficulty:
		Enums.Difficulty.EASY:
			return rng.randi_range(20, 35)
		Enums.Difficulty.MEDIUM:
			return rng.randi_range(40, 60)
		Enums.Difficulty.HARD:
			return rng.randi_range(80, 100)
		Enums.Difficulty.IMPOSSIBLE:
			return rng.randi_range(120, 140)
	return 0 # Should never reach here


