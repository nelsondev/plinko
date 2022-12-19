extends Control

onready var TweenNode = get_node("PowerBar/Tween")
var current_charge = 0
var charge_level = 0


func _ready():
	Game.connect("charge_added", self, "_animate_power_bar")
		
func _animate_power_bar():
	var charge_factor = Game.charge*5
	
	TweenNode.stop_all()
	TweenNode.interpolate_property($PowerBar, "value", current_charge, charge_factor, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.start()
	
func _on_Tween_tween_all_completed():
	var charge_factor = Game.charge*5
	current_charge = charge_factor
	print(current_charge)
	if (current_charge % 20) == 0:
		charge_level += 1
		print(charge_level)
		$SideBar.value = charge_level
