class_name Game
extends Control

@onready var grid: GridNode = %GridNode
@onready var move_count: Label = %MoveCount
@onready var blocker: Control = %Blocker
@onready var thinking_box: Panel = %ThinkingBox
@onready var hint_button: HintButton = %HintButton
@onready var fast_solve_button: Button = %DirectSolveButton

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
	self.path_finder = AllPathFinder.new(TileGrid.from_state(GridState.from_array(Config.FINAL_SOLUTION_POSITIONS)))
	WorkerThreadPool.add_task(precompute_paths)

func precompute_paths() -> void:
	path_finder.compute_all_paths()
	print("We done it!")
	enable_knowledge()

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
	block_inputs()
	var solution: Array[StateTransition] = path_finder.get_path_from_state(grid.tile_grid.dump_state())
	self.solver = PathSolver.new(grid.tile_grid, solution)
	print("Ready to show path!")
	solve_timer.start()

func fast_solve_exec() -> void:
	Thread.set_thread_safety_checks_enabled(false)
	var solution: Array[StateTransition] = path_finder.get_path_from_state(grid.tile_grid.dump_state())
	self.solver = PathSolver.new(grid.tile_grid, solution)
	print("Ready to show path!")
	# hide_thinking()
	solve_timer.start()

func on_hint_request() -> void:
	var step := self.path_finder.get_first_step_from_state(grid.tile_grid.dump_state())
	var tile := grid.tile_grid.get_tile_at_pos(step.tile_pos)
	var node := grid.get_node_for_tile(tile)
	grid.make_ghost_at_tile_in_dir(node, step.direction)

func enable_knowledge() -> void:
	Thread.set_thread_safety_checks_enabled(false)
	hint_button.enable()
	fast_solve_button.show()


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
