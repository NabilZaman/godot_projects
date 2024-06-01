class_name Ruler
extends Resource

var kingdom: Kingdom
var army: Army

func _init(kingdom: Kingdom) -> void:
	self.kingdom = kingdom
