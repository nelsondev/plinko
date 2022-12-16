extends AudioStreamPlayer

signal faded

var fade_in = false
var fade_out = false
var fade_weight = 0.1
var fade_in_stop = 0.0
var fade_out_stop = -50.0

func _physics_process(delta):
	if fade_in:
		volume_db = lerp(volume_db, fade_in_stop, fade_weight)
		if round(volume_db) == round(fade_in_stop):
			volume_db = fade_in_stop
			fade_in = false
			emit_signal("faded")
	if fade_out:
		volume_db = lerp(volume_db, fade_out_stop, fade_weight)
		if round(volume_db) == round(fade_out_stop):
			volume_db = -255
			fade_out = false
			emit_signal("faded")

func fade_in(weight = 0.1):
	fade_weight = weight
	fade_in = true
	fade_out = false
func fade_out(weight = 0.1):
	fade_weight = weight
	fade_in = false
	fade_out = true
