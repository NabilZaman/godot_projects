# class_name Config # Named in autoload
extends Node

const SOLUTIONS_RESOURCE_PATH = 'res://puzzle_paths_cache.res'
const SAVES_FOLDER = 'user://saves/'

const STEP_TIME_SEC = 0.10

const CELL_HEIGHT := 100
const CELL_WIDTH := 100

const SOLUTION_PASSWORD = "ILLUSIONS"

func grid_to_global_pos(grid_pos: Vector2i) -> Vector2:
    return Vector2(grid_pos.x * CELL_WIDTH, grid_pos.y * CELL_HEIGHT)

# Calculates the nearest grid position given a global coordinate position
func global_to_grid_pos(global_pos: Vector2) -> Vector2i:
    var xpos: int = roundi( global_pos.x / CELL_WIDTH )
    var ypos: int = roundi( global_pos.y / CELL_HEIGHT )
    return Vector2i(xpos, ypos)


var INITIAL_TILE_POSITIONS: Array[Vector2i] = [
    Vector2i(2, 0),
    Vector2i(2, 3),
    Vector2i(0, 0),
    Vector2i(1, 0),
    Vector2i(0, 2),
    Vector2i(1, 2),
    Vector2i(2, 2),
    Vector2i(3, 2),
    Vector2i(0, 4),
    Vector2i(1, 4),
]

var FINAL_SOLUTION_POSITIONS: Array[Vector2i] = [
    Vector2i(1, 3),
    Vector2i(0, 2),
    Vector2i(0, 0),
    Vector2i(3, 1),
    Vector2i(1, 0),
    Vector2i(2, 1),
    Vector2i(0, 3),
    Vector2i(3, 0),
    Vector2i(0, 4),
    Vector2i(2, 0),
]
