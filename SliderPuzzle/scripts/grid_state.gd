class_name GridState
extends Resource

# For the 4 x 5, 10 tile puzzle, we have:
# 1 red 2x2 piece
# 1 yellow 2 x 1 piece
# 4 yellow 1 x 2 pieces
# 4 blue 1 x 1 pieces
var positions: Array[Vector2i]

# partially sorts the array in place
static func sort_dupes(positions: Array[Vector2i]) -> void:
    var yellows: Array[Vector2i] = positions.slice(2, 6)
    var blues: Array[Vector2i] = positions.slice(6, 10)
    blues.sort()
    yellows.sort()
    for i in range(4):
        positions[2 + i] = yellows[i]
        positions[6 + i] = blues[i]

static func from_array(positions: Array[Vector2i]) -> GridState:
    return GridState.new(positions)

# Array of (10) grid positions
func as_array(normalize: bool = true) -> Array[Vector2i]:
    var result = positions.duplicate()
    if normalize:
        GridState.sort_dupes(result)
    return result

func _init(positions: Array[Vector2i]) -> void:
    self.positions = positions
