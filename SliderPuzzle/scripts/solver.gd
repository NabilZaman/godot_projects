class_name FullSolver
extends Resource

var grid: GameGrid

var seen_states: Dictionary
var next_moves: Array[StateTransition]
var move_history: Array[StateTransition]
var backtracking := false

# returns whether this state has not yet been seen
func check_and_mark_grid_scene() -> bool:
    var new_state := grid.dump_state().as_array()
    if new_state not in seen_states:
        seen_states[new_state] = true
        return true
    return false

# returns if move was possible
func add_tile_move_if_possible(cur_state: GridState, tile: Tile, dir: Enums.Direction) -> bool:
    var rev := Enums.rev_dir(dir)
    var move_possible := false
    if tile.can_move_dir(dir):
        tile.move_dir(dir)
        if check_and_mark_grid_scene():
            next_moves.append(StateTransition.new(cur_state, tile, dir))
            move_possible = true
        tile.move_dir(rev)
    return move_possible

# returns if any moves were added
func add_next_moves() -> bool:
    var any_move_possible := false
    var cur_state := grid.dump_state()
    for tile in grid.get_tiles():
        for dir in Enums.Direction.values():
            any_move_possible = add_tile_move_if_possible(cur_state, tile, dir) or any_move_possible
    return any_move_possible

# returns if the next move is from the current state
func next_move_from_here() -> bool:
    if next_moves.is_empty():
        return false
    return grid.dump_state().as_array() == next_moves[-1].initial_state.as_array()
    
func make_move(transition: StateTransition) -> void:
    transition.tile.move_dir(transition.direction)
    transition.tile.update_global_pos(true)
    grid.update_occupied()
    move_history.append(transition)

func undo_move(transition: StateTransition) -> void:
    transition.tile.move_dir(Enums.rev_dir(transition.direction))
    grid.update_occupied()
    transition.tile.update_global_pos(true)

# evolves the grid by one step in the solution
# returns whether or not we're done (either found the solution or exhausted all moves)
func step() -> bool:
    # if we can take a move, greedily do so
    if next_move_from_here():
        make_move(next_moves.pop_back())
        backtracking = false
    elif backtracking and not move_history.is_empty(): # otherwise, if we're backtracking, just backtrack.
        undo_move(move_history.pop_back())
    elif not backtracking: # if we're not backtracking and we don't know the next move from here, it's a new position
        backtracking = not add_next_moves()
        return step()            
            
    return grid.has_won()




func _init(grid: GameGrid) -> void:
    self.grid = grid

