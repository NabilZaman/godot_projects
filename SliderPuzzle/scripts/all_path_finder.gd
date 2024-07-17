class_name AllPathFinder
extends Resource

var grid: TileGrid
var initial_state_array = Config.FINAL_SOLUTION_POSITIONS

var rng = RandomNumberGenerator.new()

## Used to solve the puzzle
# map from GridState array -> shortest path to that state (Array[StateTransition])
@export var shortest_paths: Dictionary = {}
var queue: Deque

@export var path_len_counts: Dictionary = {}

const LOG_PROGRESS := true

func enqueue_neighbor_if_new(neighbor: GridState, cur_state: GridState, tile_pos: Vector2i,
							direction: Enums.Direction, path_here: Array[StateTransition]) -> void:
	var neighbor_array := neighbor.as_array()
	if neighbor_array not in shortest_paths:
		queue.append(neighbor)
		var transition := StateTransition.new(cur_state, tile_pos, direction)
		var new_path := path_here.duplicate()
		new_path.append(transition)
		record_path(neighbor_array, new_path)

func record_path(state_array: Array[Vector2i], path: Array[StateTransition]) -> void:
	shortest_paths[state_array] = path
	var path_len = path.size()
	if path_len not in path_len_counts:
		path_len_counts[path_len] = 0
	path_len_counts[path_len] += 1

func enqueue_neighboring_states() -> void:
	var cur_state = grid.dump_state()
	var cur_path: Array[StateTransition] = []
	cur_path.assign(shortest_paths[cur_state.as_array()])

	var tiles := grid.get_tiles()
	for tile in tiles:
		for dir in Enums.Direction.values():
			var rev := Enums.rev_dir(dir)
			if grid.can_tile_move_dir(tile, dir):
				var old_pos := tile.pos
				tile.move_dir(dir)
				enqueue_neighbor_if_new(grid.dump_state(), cur_state, old_pos, dir, cur_path)
				tile.move_dir(rev)

func compute_all_paths() -> void:
	print("Finding shortest path!")
	var start_time = Time.get_unix_time_from_system()
	var i: int = 0
	while not queue.is_empty():
		i += 1
		if LOG_PROGRESS and i % 2000 == 0:
			var cur_state = grid.dump_state()
			var cur_path: Array[StateTransition] = []
			cur_path.assign(shortest_paths[cur_state.as_array()])
			print(i)
			print(len(shortest_paths))
			print(queue.size())
			print(len(cur_path))
			print("=======")
		var new_state = queue.pop_front()
		grid.load_state(new_state)

		# enqueue all the neighbors and update their paths
		enqueue_neighboring_states()

	print("Found all paths in %.2f seconds!" % (Time.get_unix_time_from_system() - start_time))

func get_random_state_n_steps_away(n: int) -> GridState:
	var rand_index: int = rng.randi_range(0, path_len_counts[n])
	var rand_path: Array[StateTransition] = []
	for path in shortest_paths.values():
		if path.size() == n:
			if rand_index == 0:
				rand_path.assign(path)
				break
			else:
				rand_index -= 1
	var rand_grid := TileGrid.from_state(GridState.from_array(initial_state_array))
	for transition in rand_path:
		rand_grid.get_tile_at_pos(transition.tile_pos).move_dir(transition.direction)
	return rand_grid.dump_state()

func get_first_step_from_state(target_state: GridState) -> StateTransition:
	var path_from_state := get_path_from_state(target_state)
	if path_from_state.is_empty():
		return null
	else:
		return path_from_state[0]

# Determine if we've computed the path to a given state yet
func has_path_to_state(target_state: GridState) -> bool:
	return target_state.as_array() in shortest_paths

# Get the shortest path to a given state from the initial state
func get_path_to_state(target_state: GridState) -> Array[StateTransition]:
	var path: Array[StateTransition] = []
	if not has_path_to_state(target_state):
		return path
	path.assign(shortest_paths[target_state.as_array()])
	return path

# Get the shortest path to the initial state from the given state
# We do this by finding the shortest path there and reversing it
func get_path_from_state(target_state: GridState) -> Array[StateTransition]:
	var forward_path := get_path_to_state(target_state)
	var rev_path: Array[StateTransition] = []
	for i in range(forward_path.size()):
		var forward_step := forward_path[i]
		var rev_dir = Enums.rev_dir(forward_step.direction)
		# Make a tile to measure the final state of this transition
		var final_tile := Tile.new(forward_step.tile_pos)
		final_tile.move_dir(forward_step.direction)
		# The initial states are not needed to follow the path so we don't bother building them
		rev_path.append(StateTransition.new(null, final_tile.pos, rev_dir))
	rev_path.reverse()
	return rev_path

func get_length_to_state(target_state: GridState) -> int:
	return get_path_to_state(target_state).size()

func _init(grid: TileGrid = null) -> void:
	self.grid = grid
	if grid != null:
		var cur_state := grid.dump_state()
		self.queue = Deque.new()
		self.queue.append(cur_state)
		var empty_path: Array[StateTransition] = []
		record_path(cur_state.as_array(), empty_path)
