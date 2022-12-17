extends Control

onready var TweenNode = get_node("PowerBar/Tween")
var current_charge = 0

func _ready():
	Game.connect("charge_added", self, "_animate_power_bar")
		
func _animate_power_bar():
	var charge_factor = Game.charge*5
	
	TweenNode.stop_all()
	TweenNode.interpolate_property($PowerBar, "value", current_charge, charge_factor, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.start()
	
	current_charge = charge_factor

