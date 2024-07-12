class_name Game
extends Control

@onready var grid: GridNode = %GridNode
@onready var move_count: Label = %MoveCount
@onready var blocker: Control = %Blocker
@onready var thinking_box: Panel = %ThinkingBox

var solving: bool
var solver: Solver
var solve_timer: Timer
var solve_thread: Thread

var moves_taken: int

func setup_grid():
	var tiles: Array[Tile] = []
	tiles.append(FourTile.new(Config.INITIAL_TILE_POSITIONS[0]))
	tiles.append(TwoHTile.new(Config.INITIAL_TILE_POSITIONS[1]))
	for i in range(2, 6):
		tiles.append(TwoVTile.new(Config.INITIAL_TILE_POSITIONS[i]))
	for i in range(6, 10):
		tiles.append(OneTile.new(Config.INITIAL_TILE_POSITIONS[i]))
	var new_grid := TileGrid.new(tiles)
	grid.set_grid(new_grid)

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
	self.solver = PathSolver.new(grid.tile_grid.copy())
	solve_thread.start(fast_solve_exec)

func fast_solve_exec() -> void:
	print(solver)
	print(solve_timer)
	Thread.set_thread_safety_checks_enabled(false)
	solver.find_shortest_path()
	solver.grid = grid.tile_grid # replace the copy we used for solving with the real thing
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
