class_name GridNode
extends Control

var tile_grid: TileGrid
var grid_setup: bool

var tile_to_node_map: Dictionary

signal move_made()


func get_tile_nodes() -> Array[TileNode]:
    var children: Array[TileNode] = []
    children.assign(get_children())
    return children

# The highest y value allowed: either the current grid value or the grid value of the position above us if we can move up
func get_tile_up_bound(node: TileNode) -> float:
    if tile_grid.can_tile_move_up(node.tile):
        return Config.grid_to_global_pos(node.tile.pos + Vector2i(0, -1)).y
    else:
        return Config.grid_to_global_pos(node.tile.pos).y

# The lowest y value allowed: either the current grid value or the grid value of the position below us if we can move down
func get_tile_down_bound(node: TileNode) -> float:
    if tile_grid.can_tile_move_down(node.tile):
        return Config.grid_to_global_pos(node.tile.pos + Vector2i(0, 1)).y
    else:
        return Config.grid_to_global_pos(node.tile.pos).y

# The lowest x value allowed: either the current grid value or the grid value of the position left of us if we can move left
func get_tile_left_bound(node: TileNode) -> float:
    if tile_grid.can_tile_move_left(node.tile):
        return Config.grid_to_global_pos(node.tile.pos + Vector2i(-1, 0)).x
    else:
        return Config.grid_to_global_pos(node.tile.pos).x

# The lowest x value allowed: either the current grid value or the grid value of the position left of us if we can move left
func get_tile_right_bound(node: TileNode) -> float:
    if tile_grid.can_tile_move_right(node.tile):
        return Config.grid_to_global_pos(node.tile.pos + Vector2i(1, 0)).x
    else:
        return Config.grid_to_global_pos(node.tile.pos).x

func on_tile_move() -> void:
    move_made.emit()

func setup_tile_nodes() -> void:
    var tile_nodes := get_tile_nodes()
    var tiles := tile_grid.get_tiles()
    for i in range(len(tile_nodes)):
        var tile: Tile = tiles[i]
        var tile_node: TileNode = tile_nodes[i]
        tile_to_node_map[tile] = tile_node
        tile_node.set_tile(tile)
        tile_node.moved.connect(on_tile_move)
    grid_setup = true

func set_grid(grid: TileGrid) -> void:
    self.tile_grid = grid
    if not grid_setup:
        setup_tile_nodes()

func refresh_tiles(should_tween: bool = true) -> void:
    for node in get_tile_nodes():
        node.update_global_pos(should_tween)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if tile_grid and not grid_setup:
        setup_tile_nodes()

func _process(_delta: float) -> void: #TODO: Use signals to know which tile is selected
    for tile_node in get_tile_nodes():
        if tile_node.am_selected:
            tile_node.handle_movement(
                get_tile_left_bound(tile_node),
                get_tile_right_bound(tile_node),
                get_tile_up_bound(tile_node),
                get_tile_down_bound(tile_node)
            )

