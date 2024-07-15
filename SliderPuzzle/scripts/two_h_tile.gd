class_name TwoHTile
extends Tile

# Override
func occupied_positions() -> Array[Vector2i]:
    var right := Vector2i(pos.x + 1, pos.y)
    return [pos, right]

# Override
func copy() -> TwoHTile:
    var copy_tile := super()
    return TwoHTile.new(copy_tile.pos)