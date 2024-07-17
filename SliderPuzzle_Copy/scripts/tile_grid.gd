class_name TileGrid
extends Resource

const COLUMNS := 4
const ROWS := 5

# Tiles - order matters
# For the 4 x 5, 10 tile puzzle, we have:
# 1 red 2x2 piece
# 1 yellow 2 x 1 piece
# 4 yellow 1 x 2 pieces
# 4 blue 1 x 1 pieces
@export var tiles: Array[Tile]
@export var four_tile: FourTile

func get_tiles() -> Array[Tile]:
    return tiles

func get_tile(index: int) -> Tile:
    return tiles[index]

func get_tile_at_pos(pos: Vector2i) -> Tile:
    for tile in tiles:
        if tile.pos == pos:
            return tile
    return null

func is_occupied(pos: Vector2i) -> bool:
    for child in get_tiles():
        if pos in child.occupied_positions():
            return true
    return false

func can_tile_move_left(tile: Tile) -> bool:
    # Record the left-most position of this tile in each row
    var leftmost_col_per_row := {}
    for occupied_pos in tile.occupied_positions():
        if occupied_pos.y not in leftmost_col_per_row or leftmost_col_per_row[occupied_pos.y] > occupied_pos.x:
            leftmost_col_per_row[occupied_pos.y] = occupied_pos.x
    for row in leftmost_col_per_row:
        var col: int = leftmost_col_per_row[row]
        if col <= 0 or is_occupied(Vector2i(col - 1, row)):
            return false
    return true

func can_tile_move_right(tile: Tile) -> bool:
    # Record the right-most position of this tile in each row
    var rightmost_col_per_row := {}
    for occupied_pos in tile.occupied_positions():
        if occupied_pos.y not in rightmost_col_per_row or rightmost_col_per_row[occupied_pos.y] < occupied_pos.x:
            rightmost_col_per_row[occupied_pos.y] = occupied_pos.x
    for row in rightmost_col_per_row:
        var col: int = rightmost_col_per_row[row]
        if col >= COLUMNS-1 or is_occupied(Vector2i(col + 1, row)):
            return false
    return true

func can_tile_move_up(tile: Tile) -> bool:
    # Record the top-most position of this tile in each col
    var topmost_row_per_col := {}
    for occupied_pos in tile.occupied_positions():
        if occupied_pos.x not in topmost_row_per_col or topmost_row_per_col[occupied_pos.x] > occupied_pos.y:
            topmost_row_per_col[occupied_pos.x] = occupied_pos.y
    for col in topmost_row_per_col:
        var row: int = topmost_row_per_col[col]
        if row <= 0 or is_occupied(Vector2i(col, row-1)):
            return false
    return true

func can_tile_move_down(tile: Tile) -> bool:
    # Record the top-most position of this tile in each col
    var bottommost_row_per_col := {}
    for occupied_pos in tile.occupied_positions():
        if occupied_pos.x not in bottommost_row_per_col or bottommost_row_per_col[occupied_pos.x] < occupied_pos.y:
            bottommost_row_per_col[occupied_pos.x] = occupied_pos.y
    for col in bottommost_row_per_col:
        var row: int = bottommost_row_per_col[col]
        if row >= ROWS-1 or is_occupied(Vector2i(col, row+1)):
            return false
    return true

func can_tile_move_dir(tile: Tile, dir: Enums.Direction) -> bool:
    match dir:
        Enums.Direction.LEFT:
            return can_tile_move_left(tile)
        Enums.Direction.RIGHT:
            return can_tile_move_right(tile)
        Enums.Direction.UP:
            return can_tile_move_up(tile)
        Enums.Direction.DOWN:
            return can_tile_move_down(tile)
    return false

func renormalize() -> void:
    load_state(dump_state())

func load_state(state: GridState) -> void:
    # for each child, load its position from the state
    var children: Array[Tile] = get_tiles()
    var new_positions: Array[Vector2i] = state.as_array()
    for i in range(len(children)):
        var child := children[i]
        child.pos = new_positions[i]

func dump_state() -> GridState:
    var grid_positions: Array[Vector2i] = []
    for child in get_tiles():
        grid_positions.append(child.pos)
    return GridState.from_array(grid_positions)

static func from_state(state: GridState) -> TileGrid:
    var tiles: Array[Tile] = []
    var grid_positions := state.as_array()
    tiles.append(FourTile.new(grid_positions[0]))
    tiles.append(TwoHTile.new(grid_positions[1]))
    for i in range(2, 6):
        tiles.append(TwoVTile.new(grid_positions[i]))
    for i in range(6, 10):
        tiles.append(OneTile.new(grid_positions[i]))

    return TileGrid.new(tiles)

# detects if the grid has been won
func has_won() -> bool:
    return four_tile.pos == Vector2i(1, 3)

# Returns a new TileGrid
func copy() -> TileGrid:
    print("Copying!")
    var new_tiles: Array[Tile] = []
    for tile in get_tiles():
        new_tiles.append(tile.copy())
    print(new_tiles)
    return TileGrid.new(new_tiles)

func _init(tiles: Array[Tile]) -> void:
    self.tiles = tiles.duplicate()
    # assume the four-tile is always in the first position
    self.four_tile = tiles[0]
