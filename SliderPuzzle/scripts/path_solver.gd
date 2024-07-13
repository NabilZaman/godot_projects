class_name PathSolver
extends Solver

var grid: TileGrid

var path: Array[StateTransition]
var cur_step: int = 0

func make_move(transition: StateTransition) -> void:
	grid.get_tiles()[transition.tile_index].move_dir(transition.direction)

# Override
# evolves the grid by one step in the solution
# returns whether or not we're done (either found the solution or exhausted all moves)
func step() -> bool:
	if cur_step >= len(path):
		return true
	# we assume the grid begins in the same starting state as it was when the path was solved
	var move := path[cur_step]
	print(move.tile_index, "->", move.direction)
	make_move(move)
	cur_step += 1
	return false

func _init(grid: TileGrid, path: Array[StateTransition]) -> void:
	self.grid = grid
	self.path = path
	
