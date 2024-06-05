extends Node

var turn_count: int = 0
var player: Player = Player.new()


func change_gold(delta: int) -> void:
	self.player.gold += delta
	Signals.gold_changed.emit(self.player.gold)

func consume_action(action_cost: float) -> void:
	if self.player.actions > action_cost:
		self.player.actions -= action_cost
		Signals.actions_changed.emit()

func end_turn() -> void:
	self.player.refresh_actions()
	self.turn_count += 1
	Signals.turn_changed.emit(self.turn_count)
