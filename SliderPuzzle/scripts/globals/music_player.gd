# class_name MusicPlayer # Named in autoload
extends Node


const MUSIC_BUS = "Music"
var player: AudioStreamPlayer

@onready var tracks_paths: Array[String] = [
    'res://assets/music/track1.mp3',
    'res://assets/music/track2.mp3'
]

var tracks: Array[AudioStream]
var cur_track := 0

func advance_track() -> void:
    if tracks.is_empty():
        return
    cur_track = (cur_track + 1) % tracks.size()
    stop()
    play()

# Takes a volume flaot 0 and 1
func set_volume(volume: float) -> void:
    var db_value = linear_to_db(clamp(volume, 0.0, 1.0))
    player.volume_db = db_value

func play() -> void:
    if cur_track >= len(tracks):
        return
    player.stream = tracks[cur_track]
    player.play()

func stop() -> void:
    player.stop()

func load_tracks() -> void:
    for path in tracks_paths:
        tracks.append(load(path))

func _ready() -> void:
    self.player = AudioStreamPlayer.new()
    self.player.bus = MUSIC_BUS
    self.player.finished.connect(advance_track)
    self.add_child(player)
    self.set_volume(0.5)
    load_tracks()
    play()

# func _input(event: InputEvent) -> void:
#     if event.is_released() and event is InputEventKey and KEY_SPACE == event.keycode:
#         advance_track()

