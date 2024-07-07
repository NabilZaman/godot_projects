class_name Game
extends Control

const STEP_TIME_SEC = 0.33

@onready var grid: GameGrid = %GameGrid

var solver: Solver
var solve_timer: Timer


# # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.solver = Solver.new(grid)
	self.solve_timer = Timer.new()
	add_child(solve_timer)
	solve_timer.wait_time = STEP_TIME_SEC
	solve_timer.timeout.connect(step_solver)

func step_solver() -> void:
	solver.step()

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass

func solve_puzzle() -> void:
	# step through the solver
	solve_timer.start()
	
