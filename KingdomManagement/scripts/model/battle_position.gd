class_name BattlePosition
extends Resource

var role: Enums.Role

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
    assert(len(pos) == 3)
    var role = pos[0]
    var row = pos[1]
    var col = pos[2]
    return BattlePosition.new(role, row, col)

func as_array() -> Array[int]:
    return [role, row, col]

func _init(role: Enums.Role, row: int, col: int) -> void:
    assert(0 <= row and row <= 2)
    assert(0 <= col and col <= 2)
    self.role = role
    self.row = row
    self.col = col
