class_name GridPosition
extends Resource

var x: int
var y: int

var UP_LEFT: GridPosition:
	get:
		return GridPosition.new(x-1, y-1)
var UP_RIGHT: GridPosition:
	get:
		return GridPosition.new(x+1, y-1)
var RIGHT: GridPosition:
	get:
		return GridPosition.new(x+2, y)
var DOWN_RIGHT: GridPosition:
	get:
		return GridPosition.new(x+1, y+1)
var DOWN_LEFT: GridPosition:
	get:
		return GridPosition.new(x-1, y+1)
var LEFT: GridPosition:
	get:
		return GridPosition.new(x-2, y)

func neighbors() -> Array[GridPosition]:
	return [UP_LEFT, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN_LEFT, LEFT]

# This allows for a pos to be the neighbor of itself
func is_neighbor(pos: GridPosition) -> bool:
	return abs(pos.y - self.y) <= 1 and abs(pos.x - self.x) <= 2

func as_vector() -> Vector2i:
	return Vector2i(x, y)

func _init(x: int, y: int) -> void:
	self.x = x
	self.y = y

