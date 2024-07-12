class_name PathSolver
extends Solver

var grid: TileGrid

## Used to solve the puzzle
# map from GridState array -> shortest path to that state (Array[StateTransition])
var shortest_paths: Dictionary = {}
var queue: Deque

## Used to play back the solution
var winning_path: Array[StateTransition]
var cur_step: int = 0

func enqueue_neighbor_if_new(neighbor: GridState, cur_state: GridState, tile_index: int,
							direction: Enums.Direction, path_here: Array[StateTransition]) -> void:
	var neighbor_array := neighbor.as_array()
	if neighbor_array not in shortest_paths:
		queue.append(neighbor)
		var transition := StateTransition.new(cur_state, tile_index, direction)
		var new_path := path_here.duplicate()
		new_path.append(transition)
		shortest_paths[neighbor_array] = new_path

func enqueue_neighboring_states() -> void:
	var cur_state = grid.dump_state()
	var cur_path: Array[StateTransition] = []
	cur_path.assign(shortest_paths[cur_state.as_array()])

	var tiles := grid.get_tiles()
	for i in range(tiles.size()):
		var tile := tiles[i]
		for dir in Enums.Direction.values():
			var rev := Enums.rev_dir(dir)
			if grid.can_tile_move_dir(tile, dir):
				tile.move_dir(dir)
				enqueue_neighbor_if_new(grid.dump_state(), cur_state, i, dir, cur_path)
				tile.move_dir(rev)

func find_shortest_path() -> Array[StateTransition]:
	print("Finding shortest path!")
	var start_time = Time.get_unix_time_from_system()
	var shortest_path: Array[StateTransition] = []
	var i: int = 0
	while not queue.is_empty():
		i += 1
		if i % 2000 == 0:
			print("=======")
			print(i)
			print(len(shortest_paths))
			print(queue.size())
		var new_state = queue.pop_front()
		# print(queue.size())
		# print(new_state)
		grid.load_state(new_state)
		# if we've arrived at the winning state, stop here
		if grid.has_won():
			break
		# otherwise enqueue all the neighbors and update their paths
		enqueue_neighboring_states()

	# if we broke out early at a winning state, record the path to here
	if grid.has_won():
		print("We won!")
		shortest_path.assign(shortest_paths[grid.dump_state().as_array()])
		self.winning_path = shortest_path

	print("Found shortest path in %.2f seconds!" % (Time.get_unix_time_from_system() - start_time))
	return shortest_path

func make_move(transition: StateTransition) -> void:
	grid.get_tiles()[transition.tile_index].move_dir(transition.direction)

# Override
# evolves the grid by one step in the solution
# returns whether or not we're done (either found the solution or exhausted all moves)
func step() -> bool:
	if cur_step >= len(winning_path):
		return true
	# we assume the grid begins in the same starting state as it was when the path was solved
	var move := winning_path[cur_step]
	make_move(move)
	cur_step += 1
	return false

func _init(grid: TileGrid) -> void:
	self.grid = grid
	var cur_state := grid.dump_state()
	self.queue = Deque.new()
	self.queue.append(cur_state)
	self.shortest_paths[cur_state.as_array()] = []
