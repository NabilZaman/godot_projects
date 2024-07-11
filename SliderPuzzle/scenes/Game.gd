class_name Game
extends Control

@onready var grid: GameGrid = %GameGrid
@onready var move_count: Label = %MoveCount
@onready var blocker: Control = %Blocker
@onready var thinking_box: Panel = %ThinkingBox

var solving: bool
var solver: Solver
var solve_timer: Timer
var solve_thread: Thread

var moves_taken: int


# # Called when the node enters the scene tree for the first time.
func _ready() -> void:
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

func solve_puzzle_slow() -> void:
	block_inputs()
	self.solver = FullSolver.new(grid)
	solve_timer.start()

func solve_puzzle_fast() -> void:
	self.solve_thread = Thread.new()
	block_inputs()
	show_thinking()
	self.solver = PathSolver.new(grid)
	solve_thread.start(fast_solve_exec)

func fast_solve_exec() -> void:
	print(solver)
	print(solve_timer)
	Thread.set_thread_safety_checks_enabled(false)
	solver.find_shortest_path()
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
