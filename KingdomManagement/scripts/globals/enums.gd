extends Node

enum TerritoryLevel {FORT, SETTLEMENT, TOWN, CITY}
enum TerritoryOwner {PLAYER, NPC} # Expand to full cast of options... or support generic id

const ActionCost = {"FULL": 1, "HALF": 0.5,}

enum UnitType {
	SWORDSMAN,
	SPEARMAN,
	ARCHER,
	TREBUCHET,
	OFFENSE_MAGE,
	DEFENSE_MAGE,
	HEALER_MAGE
}
