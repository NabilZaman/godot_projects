class_name OneTile
extends Tile

# Override
func occupied_positions() -> Array[Vector2i]:
    return [pos]

# Override
func copy() -> OneTile:
    var copy_tile := super()
    return OneTile.new(copy_tile.pos)

