class_name Solver
extends Resource

var grid: GameGrid

var seen_states: Dictionary
var state_stack: Array[GridState]

func find_neighboring_states() -> Array[GridState]:
	var neighbors: Array[GridState] = []
	for tile in grid.get_tiles():
		if tile.can_move_left():
			tile.move_left()
			neighbors.append(grid.dump_state())
			tile.move_right()
		if tile.can_move_right():
			tile.move_right()
			neighbors.append(grid.dump_state())
			tile.move_left()
		if tile.can_move_up():
			tile.move_up()
			neighbors.append(grid.dump_state())
			tile.move_down()
		if tile.can_move_down():
			tile.move_down()
			neighbors.append(grid.dump_state())
			tile.move_up()

	return neighbors

# evolves the grid by one step in the solution
# returns whether or not we're done (either found the solution or exhausted all moves)
func step() -> bool:
	# 1. get all possible moves
	var neighbors: Array[GridState] = find_neighboring_states()
	
	# 2. push any states we haven't seen yet onto the stack
	for neighbor in neighbors:
		if neighbor not in seen_states:
			state_stack.append(neighbor)
			seen_states[neighbor] = true

	# 3. pop the top element of the stack and load that into the grid
	if not state_stack.is_empty():
		var next_state: GridState = state_stack.pop_back()
		grid.load_state(next_state)
	else:
		return true

	# return true if we're out of moves or found the solution
	return grid.has_won()




func _init(grid: GameGrid) -> void:
	self.grid = grid

