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
