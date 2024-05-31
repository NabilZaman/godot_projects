extends Node

# Menu
signal open_tile_menu(territory: Territory)
signal close_tile_menu()

# Resources
signal gold_changed(new_value: int)
signal troops_changed(new_value: int)
signal commanders_changed(new_value: int)

# Actions
signal turn_changed(new_value: int)
signal actions_changed(new_value: int)
