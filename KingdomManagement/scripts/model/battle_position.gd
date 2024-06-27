class_name BattlePosition
extends Resource

# row here indicates the front/backline of units.
# row 0 is always the frontline, row1 is always the backline
# visually these will be drawn differently (left/right)
# depending on the side of the battle these units are appearing in.
var row: int

# col here indicates the left/right/center order of units.
# col 0 is the left-unit, col 0 is the cnter-unit, and col 2 is the right-unit
# visually these will be drawn differently (top/middle/bottom)
# depending on the side of the battle these units are appearing in.
var col: int

static func from_array(pos: Array[int]):
    assert(len(pos) == 2)
    var row = pos[0]
    var col = pos[1]
    return BattlePosition.new(row, col)

func as_array() -> Array[int]:
    return [row, col]

func _init(row: int, col: int) -> void:
    assert(0 <= row and row <= 2)
    assert(0 <= col and col <= 2)
    self.row = row
    self.col = col
