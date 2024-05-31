class_name LabelSignalConnector
extends RefCounted

var _signal: Signal
var _label: Label

func on_signal(new_val) -> void:
	self._label.text = str(new_val)

func _init(_signal: Signal, _label: Label) -> void:
	self._label = _label
	_signal.connect(on_signal)
