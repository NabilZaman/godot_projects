# class_name Enums # Named in autoload config
extends Node

enum Direction {LEFT, RIGHT, UP, DOWN}

func rev_dir(dir: Direction) -> Direction:
    match dir:
        Direction.LEFT:
            return Direction.RIGHT
        Direction.RIGHT:
            return Direction.LEFT
        Direction.UP:
            return Direction.DOWN
        Direction.DOWN:
            return Direction.UP
    return Direction.LEFT # Should never reach this line

func dir_vector(dir: Direction) -> Vector2i:
    match dir:
        Direction.LEFT:
            return Vector2i(-1, 0)
        Direction.RIGHT:
            return Vector2i(1, 0)
        Direction.UP:
            return Vector2i(0, -1)
        Direction.DOWN:
            return Vector2i(0, 1)
    return Vector2i(0, 0) # Should never reach this line

