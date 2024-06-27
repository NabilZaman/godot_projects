extends Node2D

const GAME = preload("res://scenes/game.tscn")
const BATTLE = preload("res://scenes/BattleScene.tscn")

func start_game() -> void:
	start_battle()

func start_map() -> void:
	get_tree().change_scene_to_packed(GAME)

func setup_battle() -> Battle:
	var enemy_archer = UnitGenerator.random_archer()
	enemy_archer.battle_pos = BattlePosition.new(1,1)
	var enemy_swordsman = UnitGenerator.random_swordsman()
	enemy_swordsman.battle_pos = BattlePosition.new(0,2)
	var enemy_shieldbearer = UnitGenerator.random_shieldbearer()
	enemy_shieldbearer.battle_pos = BattlePosition.new(0,1)

	var player_archer = UnitGenerator.random_archer()
	player_archer.battle_pos = BattlePosition.new(1,1)
	var player_swordsman = UnitGenerator.random_swordsman()
	player_swordsman.battle_pos = BattlePosition.new(0,0)
	var player_shieldbearer = UnitGenerator.random_shieldbearer()
	player_shieldbearer.battle_pos = BattlePosition.new(0,1)
	var attackers: Array[CombatUnit] = [player_archer, player_swordsman, player_shieldbearer]
	var defenders: Array[CombatUnit] = [enemy_archer, enemy_shieldbearer, enemy_swordsman]
	return Battle.new(attackers, defenders, true)

func start_battle() -> void:
	var battle_scene: BattleScene = BATTLE.instantiate()
	battle_scene.setup(setup_battle())
	var root = get_tree().root
	root.add_child(battle_scene)
	self.queue_free()


func quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

