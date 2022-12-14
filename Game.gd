extends Node2D

signal charge_added
var charge = 0

func get_root(): return get_tree().current_scene
func get_camera(): return get_root().get_node("Board/Camera2D")

func add_charge(amount = 1): 
	charge += 1
	emit_signal("charge_added")
