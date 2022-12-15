extends Node2D

signal hits_added

var hits = 0
var charge = 0

func get_root(): return get_tree().current_scene
func get_camera(): return get_root().get_node("Board/Camera2D")

func add_hits(amount = 1): 
	hits += 1
	
	if hits < 2: charge = 0
	if hits < 4: charge = 1
	if hits < 8: charge = 2
	if hits < 16: charge = 3
	
	emit_signal("hits_added")
