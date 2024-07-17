class_name TwoVTile
extends Tile

# Override
func occupied_positions() -> Array[Vector2i]:
    var down := Vector2i(pos.x, pos.y + 1)
    return [pos, down]

# Override
func copy() -> TwoVTile:
    var copy_tile := super()
    return TwoVTile.new(copy_tile.pos)