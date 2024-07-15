class_name FourTile
extends Tile

# Override
func occupied_positions() -> Array[Vector2i]:
    var right := Vector2i(pos.x + 1, pos.y)
    var down := Vector2i(pos.x, pos.y + 1)
    var down_right := Vector2i(pos.x + 1, pos.y + 1)
    return [pos, right, down, down_right]

# Override
func copy() -> FourTile:
    var copy_tile := super()
    return FourTile.new(copy_tile.pos)