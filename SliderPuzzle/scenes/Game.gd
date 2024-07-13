class_name Game
extends Control

@onready var grid: GridNode = %GridNode
@onready var move_count: Label = %MoveCount
@onready var blocker: Control = %Blocker
@onready var thinking_box: Panel = %ThinkingBox

var solving: bool
var solver: Solver
var path_finder: AllPathFinder
var solve_timer: Timer
var solve_thread: Thread

var moves_taken: int

"""
0->1   1->3
6->1   8->3
6->3   7->1
1->3   5->1
2->3   3->3
4->3   3->3
9->0   0->0
7->0   7->2
3->2   8->2
9->0   7->2
7->0   8->2
5->2   5->1
0->2   3->1
6->1   9->2
6->1   9->2
8->1   6->1
8->1   6->2
1->3   1->0
4->3   1->0
7->3   3->3
9->1   9->1
2->2   5->3
4->0   9->1
0->0   0->3
3->3   7->0
3->3   8->2
5->1   9->2
7->1   7->0
9->1   8->0
2->1   9->2
4->2   5->2
4->2   5->2
0->0   3->1
8->2   6->1
6->0   6->3
3->3   0->3
5->3   8->3
8->2   7->1
9->1   2->1
7->2   4->2
8->2   4->2
0->1   0->0
4->3   8->3
4->3   7->3
2->0   9->0
7->0   8->3
8->2   5->2
0->2   3->2
6->2   6->1
6->0   8->3
3->0   0->1
5->3   4->3
5->3   4->3
9->3   2->0
8->1   9->0
7->1   7->0
9->3   5->0
8->3   3->2
7->1   3->2
0->2   0->1
9->0   4->1
5->2   2->3
9->0   9->0
3->2   7->2
1->1   4->2
1->1   1->2
6->3   8->0
6->0   8->0
9->3   6->0
9->3   6->0
3->0   0->3
5->0   5->3
8->3   7->1
7->3   9->1
8->3   3->3
7->3   7->1
0->1   9->1
3->2   4->2
3->2   2->2
5->0   1->2
7->0   6->2
8->2   6->0
1->2   0->0
"""

func setup_grid():
	# var new_grid := TileGrid.from_state(GridState.from_array(Config.FINAL_SOLUTION_POSITIONS))
	var new_grid := TileGrid.from_state(GridState.from_array(Config.INITIAL_TILE_POSITIONS))
	grid.set_grid(new_grid)
	grid.refresh_tiles()

# # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()
	self.solve_timer = Timer.new()
	add_child(solve_timer)
	solve_timer.wait_time = Config.STEP_TIME_SEC
	solve_timer.timeout.connect(step_solver)
	grid.move_made.connect(add_move)

func step_solver() -> void:
	add_move()
	if solver.step():
		solve_timer.stop()
		allow_inputs()
	grid.refresh_tiles()

func solve_puzzle_slow() -> void:
	block_inputs()
	self.solver = FullSolver.new(grid.tile_grid)
	solve_timer.start()

func solve_puzzle_fast() -> void:
	self.solve_thread = Thread.new()
	block_inputs()
	show_thinking()
	self.path_finder = AllPathFinder.new(TileGrid.from_state(GridState.from_array(Config.FINAL_SOLUTION_POSITIONS)))
	solve_thread.start(fast_solve_exec)

func fast_solve_exec() -> void:
	Thread.set_thread_safety_checks_enabled(false)
	path_finder.compute_all_paths()
	var solution: Array[StateTransition] = path_finder.get_path_from_state(grid.tile_grid.dump_state())
	self.solver = PathSolver.new(grid.tile_grid, solution)
	print("Ready to show path!")
	hide_thinking()
	solve_timer.start()

func block_inputs() -> void:
	solving = true
	blocker.show()

func allow_inputs() -> void:
	blocker.hide()

func show_thinking() -> void:
	thinking_box.show()

func hide_thinking() -> void:
	thinking_box.hide()

func add_move() -> void:
	self.moves_taken += 1
	move_count.text = "Moves: %d" % moves_taken


func _exit_tree():
	if solve_thread:
		solve_thread.wait_to_finish()
