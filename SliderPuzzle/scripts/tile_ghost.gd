class_name TileGhost
extends TextureRect

const OPACITY = 0.25
const DISPLAY_TIME = 0.75

const MOVE_TIME = 0.5

var template: TileNode

func setup_reap_timer() -> void:
    var reap_timer = Timer.new()
    add_child(reap_timer)
    reap_timer.wait_time = DISPLAY_TIME
    reap_timer.timeout.connect(self.queue_free)
    reap_timer.start()

func move_dir(dir: Enums.Direction, distance: float) -> void:
    var new_pos := self.global_position + Enums.dir_vector(dir) * distance
    var tween := get_tree().create_tween()
    tween.tween_property(self, "global_position", new_pos, MOVE_TIME)
    setup_reap_timer()

func _init(template: TileNode) -> void:
    self.template = template
    self.texture = template.texture_normal
    self.self_modulate.a = OPACITY
    self.mouse_filter = Control.MOUSE_FILTER_IGNORE
