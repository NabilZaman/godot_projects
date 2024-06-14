extends Node

# Menu
signal open_tile_menu(hex_tile: HexTile)
signal close_tile_menu()
signal show_message(message: String)
signal get_confirmation(message: String)
signal user_response(resp: Enums.UserResponse)

# Resources
signal gold_changed(new_value: int)
signal troops_changed(army: Army)
signal commanders_changed(new_value: int)
signal population_changed(region: Region)

# Actions
signal turn_changed(new_value: int)
signal actions_changed()

# Setup

# Animations
signal map_focus_changed(tile: HexTile)

# State
signal region_captured(region: Region)
