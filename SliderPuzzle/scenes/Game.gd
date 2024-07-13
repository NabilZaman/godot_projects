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

func setup_grid():
	# var new_grid := TileGrid.from_state(GridState.from_array(Config.FINAL_SOLUTION_POSITIONS))
	var new_grid := TileGrid.from_state(GridState.from_array(Config.INITIAL_TILE_POSITIONS))
	grid.set_grid(new_grid)
	grid.refresh_tiles(false)

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
	grid.tile_grid.renormalize()
	grid.refresh_tiles(false)
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
