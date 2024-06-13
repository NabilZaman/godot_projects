extends Node

# Menu
signal open_tile_menu(hex_tile: HexTile)
signal close_tile_menu()

# Resources
signal gold_changed(new_value: int)
signal troops_changed(new_value: int)
signal commanders_changed(new_value: int)
signal population_changed(region: Region)

# Actions
signal turn_changed(new_value: int)
signal actions_changed()

# Setup

# Animations
signal map_focus_changed(tile: HexTile)
