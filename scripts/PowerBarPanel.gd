extends Control

onready var UpTweenNode = get_node("PowerBar/UpTween")
onready var DownTweenNode = get_node("PowerBar/DownTween")
onready var BarUpSound = get_node("PowerBar/BarUp")
onready var BarDownSound = get_node("PowerBar/BarDown")

var current_charge = 0
var charge_level = 0
var pitch_factor = 0



func _ready():
	Game.connect("charge_added", self, "_animate_power_bar")
	GameState.connect("turn_over", self, "_deplete_power_bar")

func _animate_power_bar():
	var charge_factor = Game.charge*5
	var bar_up_pitch_scale

	
	BarUpSound.play()
	pitch_factor += 0.1
	bar_up_pitch_scale = 1 + pitch_factor
	BarUpSound.pitch_scale = bar_up_pitch_scale
	
	UpTweenNode.interpolate_property($PowerBar, "value", current_charge, charge_factor, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	UpTweenNode.start()
	
	current_charge = charge_factor

	if (current_charge > 20):
		$SideBar.visible = true
		$SideBar.frame = 1
		Game.global_charge += 20
	if (current_charge > 40):
		$SideBar.frame = 2
		Game.global_charge += 40
	if (current_charge > 60):
		$SideBar.frame = 3
		Game.global_charge += 60
	if (current_charge > 80):
		$SideBar.frame = 4
		Game.global_charge += 80
	if (current_charge > 100):
		$SideBar.frame = 5
		Game.global_charge += 100
		
func _deplete_power_bar():
	var charge_factor = Game.charge*5
	
	BarDownSound.play()
	
	DownTweenNode.stop_all()
	DownTweenNode.interpolate_property($PowerBar, "value", charge_factor, 0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	DownTweenNode.start()
	
func _on_UpTween_tween_all_completed():
	print("cock")
	var charge_factor = Game.charge*5
	current_charge = charge_factor

	print(current_charge)
	if (current_charge == 20):
		$SideBar.visible = true
		$SideBar.frame = 1
	if (current_charge == 40):
		$SideBar.frame = 2
	if (current_charge == 60):
		$SideBar.frame = 3
	if (current_charge == 80):
		$SideBar.frame = 4
	if (current_charge == 100):
		$SideBar.frame = 5
		
func _on_DownTween_tween_all_completed():
	$SideBar/Blinker.play("Blink")
	$SideBar.visible = false
