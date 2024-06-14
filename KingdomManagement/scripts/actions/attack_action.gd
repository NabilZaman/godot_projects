class_name AttackAction
extends TileAction

func name() -> String:
	return "ATTACK"

func available() -> bool:
	if tile.feature is FortFeature:
		return true
	# otherwise it's a capital
	for fort in tile.region.forts:
		if fort.controller != GameManager.player.kingdom:
			return false
	return true

func win_effects() -> void:
	tile.feature.capture(GameManager.player.kingdom)
	# grant victory spoils (gold? troops?)

func run_attack(win_pct: float) -> void:
	var roll: float = GameManager.rng.randf() * 100
	var result: String
	var won = roll < win_pct
	var winner: Kingdom
	var loser: Kingdom
	if won:
		result = "You won!"
		winner = GameManager.player.kingdom
		loser = tile.region.kingdom
	else:
		result = "You lost!"
		loser = GameManager.player.kingdom
		winner = tile.region.kingdom
	Signals.show_message.emit("""Win Chance: %.1f%%
	Your roll: %.1f
	
	%s
	""" % [win_pct, roll, result])
	await Signals.user_response
	winner.army.damage_pct(0.1)
	loser.army.damage_pct(0.3)
	if won:
		win_effects()
	

func invoke():
	var player_troops = GameManager.player.kingdom.army.troop_count
	var enemy_troops = tile.region.kingdom.army.troop_count
	var win_pct = CombatCalculator.win_pct(player_troops, enemy_troops) * 100
	Signals.get_confirmation.emit("""
	Your Forces: %s          Enemy Forces: %s
	Your chance to win is: %.1f%%\n
	Do you want to attack?
	""" % [player_troops, enemy_troops, win_pct])
	var resp: Enums.UserResponse = await Signals.user_response
	if resp == Enums.UserResponse.CONFIRM:
		await run_attack(win_pct)
		super()

func _init(tile: HexTile):
	assert(tile.feature != null)
	super(tile)
