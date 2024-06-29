extends Node

enum TerritoryLevel {FORT, SETTLEMENT, TOWN, CITY}
enum TerritoryOwner {PLAYER, NPC} # Expand to full cast of options... or support generic id

enum ResourceType {GOLD, ORE, LUMBER, FOOD}

enum UserResponse {CONFIRM, CANCEL}

# Combat #
enum DamageType {PHYSICAL, MAGIC}
enum TargetType {ENEMY_ANY, ENEMY_NEAR, ENEMY_FAR, ALLY_ANY, ALLY_NEAR, ALLY_FAR, SELF, ANY}
enum EffectType {DAMAGE, HEAL, SHIELD, BUFF, DEBUFF, BATTLE}
enum SelectionType {IN_HARM, IN_HELP, IN_BOTH}
enum Role {ATTACKERS, DEFENDERS}

const ActionCost := {"FULL": 1.0, "HALF": 0.5,}
const BorderStyles := {
    "STYLE1": preload("res://scenes/borders/hex_border_style1.tscn"),
    "STYLE2": preload("res://scenes/borders/hex_border_style2.tscn"),
    "STYLE3": preload("res://scenes/borders/hex_border_style3.tscn"),
    "STYLE4": preload("res://scenes/borders/hex_border_style4.tscn"),
    "STYLE5": preload("res://scenes/borders/hex_border_style5.tscn"),
}

var Tiles := {
    "GRASS": GrassTile.new(preload("res://sprites/Tiles/Green Hex.png")),
    "OCEAN": OceanTile.new(preload("res://sprites/Tiles/Blue Hex.png")),
    "HILLS": HillsTile.new(preload("res://sprites/Tiles/Brown Hex.png")),
}


