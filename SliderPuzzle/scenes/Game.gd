class_name Game
extends Control

@onready var grid: GameGrid = %GameGrid
@onready var move_count: Label = %MoveCount

var solver: FullSolver
var solve_timer: Timer
var moves_taken: int

# # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.solver = FullSolver.new(grid)
	self.solve_timer = Timer.new()
	add_child(solve_timer)
	solve_timer.wait_time = Config.STEP_TIME_SEC
	solve_timer.timeout.connect(step_solver)

func step_solver() -> void:
	self.moves_taken += 1
	move_count.text = "Moves: %d" % moves_taken
	if solver.step():
		solve_timer.stop()

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass

func solve_puzzle() -> void:
	# step through the solver
	solve_timer.start()
	
