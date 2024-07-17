class_name Game
extends CanvasLayer

@onready var grid: GridNode = %GridNode
@onready var move_count_label: Label = %MoveCount
@onready var blocker: Control = %Blocker
@onready var thinking_box: Panel = %ThinkingBox
@onready var hint_button: HintButton = %HintButton
@onready var fast_solve_button: Button = %DirectSolveButton
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var game_board: Control = %GameBoard

var path_finder: AllPathFinder = preload(Config.SOLUTIONS_RESOURCE_PATH)
var solver: Solver
var solve_timer: Timer

var tile_grid: TileGrid
var moves_taken: int
var difficulty: Enums.Difficulty

func setup_grid() -> void:
    grid.set_grid(tile_grid)
    grid.refresh_tiles(false)

func setup(tile_grid: TileGrid, moves_taken: int, difficulty: Enums.Difficulty) -> void:
    self.tile_grid = tile_grid
    self.moves_taken = moves_taken
    self.difficulty = difficulty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    setup_grid()
    self.solve_timer = Timer.new()
    add_child(solve_timer)
    solve_timer.wait_time = Config.STEP_TIME_SEC
    solve_timer.timeout.connect(step_solver)
    grid.move_made.connect(add_move)
    options_menu.return_selected.connect(on_settings_close)
    options_menu.save_selected.connect(save_game)
    options_menu.set_game(self)
    setup_password_handler()

func setup_password_handler() -> void:
    var password_reader = PasswordReader.new(Config.SOLUTION_PASSWORD)
    self.add_child(password_reader)
    password_reader.password_match.connect(on_password)

func on_password() -> void:
    fast_solve_button.show()

func step_solver() -> void:
    add_move()
    tile_grid.renormalize()
    grid.refresh_tiles(false)
    if solver.step():
        solve_timer.stop()
        allow_inputs()
    grid.refresh_tiles()

func solve_puzzle_fast() -> void:
    block_inputs()
    var solution: Array[StateTransition] = path_finder.get_path_from_state(tile_grid.dump_state())
    self.solver = PathSolver.new(tile_grid, solution)
    solve_timer.start()

func on_hint_request() -> void:
    var step := path_finder.get_first_step_from_state(tile_grid.dump_state())
    if step == null:
        return
    print(step.tile_pos)
    var tile := tile_grid.get_tile_at_pos(step.tile_pos)
    var node := grid.get_node_for_tile(tile)
    grid.make_ghost_at_tile_in_dir(node, step.direction)

func on_settings() -> void:
    game_board.hide()
    options_menu.show()

func on_settings_close() -> void:
    options_menu.hide()
    game_board.show()

func block_inputs() -> void:
    blocker.show()

func allow_inputs() -> void:
    blocker.hide()

func show_thinking() -> void:
    thinking_box.show()

func hide_thinking() -> void:
    thinking_box.hide()

func add_move() -> void:
    self.moves_taken += 1
    move_count_label.text = "Moves: %d" % moves_taken

func save_game() -> void:
    var save_data := SaveData.new(tile_grid.dump_state(), moves_taken, difficulty)
    var save_name := '%s_%s.res' % [Enums.Difficulty.find_key(difficulty), Time.get_unix_time_from_datetime_string(save_data.timestamp)]
    var save_path := '%s/%s' % [Config.SAVES_FOLDER, save_name]
    if not DirAccess.dir_exists_absolute(Config.SAVES_FOLDER):
        DirAccess.make_dir_absolute(Config.SAVES_FOLDER)
    ResourceSaver.save(save_data, save_path)

func load_save_data(data: SaveData) -> void:
    var new_grid: TileGrid = TileGrid.from_state(data.state)
    setup(new_grid, data.move_count, data.difficulty)

func _input(event: InputEvent) -> void:
    if event.is_released() and event is InputEventKey:
        if event.keycode == KEY_SPACE:
            on_hint_request()

func on_win() -> void:
    # display win message
    # display confetti effect
    # show button to return to menu
    pass

