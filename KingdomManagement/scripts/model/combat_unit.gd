class_name CombatUnit
extends Resource

var unit_type: UnitType

var commander: Commander
var num_troops: int
var max_troops: int

var battle_pos: BattlePosition

var shields: int = 0

# Unusued future features
var equipment: Array = []
var buffs: Array = []

func _avg(a: int, b: int) -> int:
	return a + b / 2

func troops() -> int:
	return num_troops

func stats() -> CombatStats:
	var base_stats := unit_type.instrinsic_stats
	var commander_stats := commander.stats
	var combined := CombatStats.new(
		_avg(base_stats.attack, commander_stats.attack),
		_avg(base_stats.defence, commander_stats.defence)
	)
	return combined

func apply_damage(amount: int) -> void:
	var adjusted_damage = amount
	adjusted_damage = max(amount - shields, 0)
	shields = max(shields - adjusted_damage, 0)

	self.num_troops = max(self.num_troops - adjusted_damage, 0)
	if self.num_troops == 0:
		die()

#TODO: I kind of want the defending unit(s) to share the damage, at a reduced rate, rather than
#      shields acting as a free damage buffer
func apply_shields(amount: int) -> void:
	self.shields = max(shields, amount)

func apply_healing(amount: int) -> void:
	self.num_troops = min(num_troops + amount, max_troops)

func die() -> void:
	pass


## Combat Design Notes ##
# attack_potency: unit-type-specific attribute, effectiely just a multiplier P
#  eg. swordsman = 0.6, archer = 0.4, pikeman = 0.2
# commander attack stat: scales unit damage... somehow... number from 1 - 99,
#   just a multiplier (1 + (attack) / 100)
# outgoing attack power = # troops * potency * attack stat bonus * other buffs?
# Actual damage dealt is then calculated by the receiving unit after applying their defensive stats
#
# NOTE On Troop Sizes:
# rance uses an "adjusted troop size" which basically provides diminishing returns for recruiting up a very large unit
# basically after certain threshold additional troops count for 50% or 25% of a "real" troop (in the combat math)
# in a graduated system. Specifically troops 1-500 count for 100%, 500 - 2000 count for 50% and 2000+ count for 25% so
# a unit with 2200 nominal troops actually behaves as having 500 + (1500 * 0.5) + (200 * 0.25) = 1300 adjusted troops. This is smart.
#
# Attacks: Units will have a basic attack and optionally a special attack that are type-specific.
# They may also optionally have a commander-specific ultimate attack. This won't be unlocked until later
# in the game and until you have sufficiently leveled up the unit.
# How do we decide if a unit has a special attack? Are they always available? Are they unlocked? I feel like this should be flexible.
# Also unlocking/leveling units... how will this work? I was thinking just paying money but... I feel like an exp system would be much
# more fun.
#
####

func _init(unit_type: UnitType, commander: Commander,
			troops: int, battle_pos: BattlePosition) -> void:
	self.unit_type = unit_type
	self.commander = commander
	self.max_troops = troops
	self.num_troops = troops
	self.battle_pos = battle_pos
	

