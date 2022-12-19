extends Node2D

signal beat
signal bar

var music = {
	"travel_happy": {
		"theme": {
			"stream": preload("res://music/travel_happy.mp3"),
			"bpm": 130,
			"signature": 4
		},
		"instruments": {}
	},
	"travel_decision": {
		"theme": {
			"stream": preload("res://music/travel_decision.mp3"),
			"bpm": 130,
			"signature": 4
		},
		"instruments": {}
	},
	"travel_spooky": {
		"theme": {
			"stream": preload("res://music/travel_spooky.mp3"),
			"bpm": 130,
			"signature": 4
		},
		"instruments": {}
	}
}
var crossfade_script = preload("res://scripts/Crossfade.gd")
var level = "travel_happy"

func _ready():
	add_music(level, false)
	
func _physics_process(delta):
	if is_on_one(): emit_signal("beat")
	if is_on_new_bar(): emit_signal("bar")
	
func rem_music(level = null):
	yield(self, "bar")
	
	if level == null:
		for child in get_children():
			child.queue_free()
	else:
		for child in get_children():
			if child.name.replace("_theme", "") == level:
				child.fade_out(0.01)
				yield(child, "faded")
				child.queue_free()
func add_music(level, wait = true):
	if wait: yield(self, "bar")
	
	var m = music[level]
	var theme = m["theme"]
	
	audio(theme.stream, level + "_theme", 0)
	self.level = level
	
	for name in m["instruments"].keys():
		var track = m["instruments"][name]
		audio(track, level + "_" + name, -255)
	
func audio(stream, name, volume = -255):
	var audio = AudioStreamPlayer.new()
	audio.stream = stream
	audio.name = name
	audio.volume_db = volume
	audio.set_script(crossfade_script)
	add_child(audio)
	audio.play()
func get_track(level, name):
	return get_node(level + "_" + name)
func add_track(level, name):
	if not has_node(level + "_" + name): return
	var node = get_track(level, name)
	yield(self, "beat")
	node.volume_db = 0
func rem_track(level, name):
	if not has_node(level + "_" + name): return
	var node = get_track(level, name)
	yield(self, "beat")
	node.volume_db = -80
func has_track(level, name):
	if not has_node(level + "_" + name): return false
	var node = get_track(level, name)
	return round(node.volume_db) != -40
func crossfade(level, name1, name2):
	var track1 = get_track(level, name1)
	var track2 = get_track(level, name2)
	
	yield(self, "beat")
	
	track1.fade_in(1)
	track2.fade_out(0.005)
func fade_out(level, args, weight):
	yield(self, "beat")
	
	for arg in args:
		var track = get_track(level, arg)
		track.fade_out(weight)
func fade_in(level, args, weight):
	yield(self, "beat")
	
	for arg in args:
		var track = get_track(level, arg)
		track.fade_in(weight)
	
func is_on_one():
	if not has_node(level + "_theme"): return false
	var entry = music[level]["theme"]
	var theme = get_node(level + "_theme")
	var time = theme.get_playback_position() / 60.0
	var beat = stepify(entry.bpm * time, 0.1)
	var bar = floor(beat / entry.signature)
	return (beat / entry.signature) == int(beat / entry.signature)
	
var current_bar = 0
func is_on_new_bar():
	if not has_node(level + "_theme"): return false
	var entry = music[level]["theme"]
	var theme = get_node(level + "_theme")
	var time = theme.get_playback_position() / 60.0
	var beat = stepify(entry.bpm * time, 0.1)
	var bar = floor(beat / entry.signature)
	var new_bar = int(bar) % entry.signature == 0
	
	if new_bar and current_bar != bar:
		current_bar = bar
		return true
	else:
		return false
