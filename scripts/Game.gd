extends Node2D

func _ready():
	yield(get_tree().create_timer(10), "timeout")
	$Music.rem_music($Music.level)
	$Music.add_music("travel_decision")
	
