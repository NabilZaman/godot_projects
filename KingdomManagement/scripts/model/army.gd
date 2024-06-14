class_name Army
extends Resource

var troop_count: int
var max_troops: int
var troop_signal

func replenish(num: int) -> void:
	self.troop_count = clamp(troop_count + num, 0, max_troops)
	if troop_signal != null:
		troop_signal.emit(self)

func recruit(num: int) -> void:
	self.max_troops += num
	self.troop_count += num
	if troop_signal != null:
		troop_signal.emit(self)

func damage(num: int) -> void:
	self.replenish(-num)

func replenish_pct(pct: float) -> void:
	self.replenish(int(pct * self.max_troops))

func damage_pct(pct: float) -> void:
	self.damage(int(pct * self.troop_count))

func _init(num_troops: int, troop_signal = null) -> void:
	self.max_troops = num_troops
	self.troop_count = num_troops
	self.troop_signal = troop_signal
