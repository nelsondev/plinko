extends Control

onready var TweenNode = get_node("PowerBar/Tween")
var current_charge = 0
var charge_level = 0


func _ready():
	Game.connect("charge_added", self, "_animate_power_bar")

func _animate_power_bar():
	var charge_factor = Game.charge*5
	
	TweenNode.interpolate_property($PowerBar, "value", current_charge, charge_factor, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.start()
	
	current_charge = charge_factor
	
	if (current_charge > 20):
		$SideBar.frame = 1
	if (current_charge > 40):
		$SideBar.frame = 2
	if (current_charge > 60):
		$SideBar.frame = 3
	if (current_charge > 80):
		$SideBar.frame = 4
	if (current_charge > 100):
		$SideBar.frame = 5
	
	
func _on_Tween_tween_all_completed():
	var charge_factor = Game.charge*5
	current_charge = charge_factor

	print(current_charge)
	if (current_charge == 20):
		$SideBar.frame = 1
	if (current_charge == 40):
		$SideBar.frame = 2
	if (current_charge == 60):
		$SideBar.frame = 3
	if (current_charge == 80):
		$SideBar.frame = 4
	if (current_charge == 100):
		$SideBar.frame = 5
		
