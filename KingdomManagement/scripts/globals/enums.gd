extends Node

enum TerritoryLevel {FORT, SETTLEMENT, TOWN, CITY}
enum TerritoryOwner {PLAYER, NPC} # Expand to full cast of options... or support generic id

const ActionCost = {"FULL": 1, "HALF": 0.5,}
const BorderStyles = {
	"STYLE1": preload("res://scenes/borders/hex_border_style1.tscn"),
	"STYLE2": preload("res://scenes/borders/hex_border_style2.tscn"),
	"STYLE5": preload("res://scenes/borders/hex_border_style5.tscn"),
}
const TileStyles = {
	"GREEN": preload("res://sprites/Tiles/Green Hex.png"),
	"BLUE": preload("res://sprites/Tiles/Blue Hex.png"),
	"BROWN": preload("res://sprites/Tiles/Brown Hex.png"),
}

enum UnitType {
	SWORDSMAN,
	SPEARMAN,
	ARCHER,
	TREBUCHET,
	OFFENSE_MAGE,
	DEFENSE_MAGE,
	HEALER_MAGE
}


