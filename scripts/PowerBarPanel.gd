extends Control

onready var UpTweenNode = get_node("PowerBar/UpTween")
onready var DownTweenNode = get_node("PowerBar/DownTween")
onready var BarUpSound = get_node("PowerBar/BarUp")
onready var BarDownSound = get_node("PowerBar/BarDown")
onready var SideBarUpSound = get_node("SideBar/SideBarUp")

var current_charge = 0
var charge_level = 0
var pitch_factor = 0
var bar_up_pitch_scale = 0.2

func _ready():
	Game.connect("charge_added", self, "_animate_power_bar")
	GameState.connect("turn_over", self, "_deplete_power_bar")

func _animate_power_bar():
	var charge_factor = Game.charge*5
	
	BarUpSound.play()
	pitch_factor += 0.1
	bar_up_pitch_scale += pitch_factor
	BarUpSound.pitch_scale = bar_up_pitch_scale
	
	UpTweenNode.interpolate_property($PowerBar, "value", current_charge, charge_factor, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	UpTweenNode.start()
	
	current_charge = charge_factor

	if (current_charge > 20):
		$SideBar.visible = true
		charge_level = 1
		$SideBar.frame = charge_level
		Game.global_charge += 20
	if (current_charge > 40):
		charge_level = 2
		$SideBar.frame = charge_level
		Game.global_charge += 20
	if (current_charge > 60):
		charge_level = 3
		$SideBar.frame = charge_level
		Game.global_charge += 20
	if (current_charge > 80):
		charge_level = 4
		$SideBar.frame = charge_level
		Game.global_charge += 20
	if (current_charge > 100):
		charge_level = 5
		$SideBar.frame = charge_level
		Game.global_charge += 20
		
func _deplete_power_bar():
	var charge_factor = Game.charge*5
	if Game.charge > 0:
		BarDownSound.play()
	
	DownTweenNode.stop_all()
	DownTweenNode.interpolate_property($PowerBar, "value", charge_factor, 0, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	DownTweenNode.start()
	
func _on_UpTween_tween_all_completed():
	var charge_factor = Game.charge*5
	current_charge = charge_factor

	print(current_charge)
	
	if (current_charge == 20):
		$SideBar.visible = true
		charge_level = 1
		$SideBar.frame = charge_level
	if (current_charge == 40):
		charge_level = 2
		$SideBar.frame = charge_level
	if (current_charge == 60):
		charge_level = 3
		$SideBar.frame = charge_level
	if (current_charge == 80):
		charge_level = 4
		$SideBar.frame = charge_level
	if (current_charge == 100):
		charge_level = 5
		$SideBar.frame = charge_level
		
func _on_DownTween_tween_all_completed():
	if charge_level != 0:
		$SideBar/Blinker.play("Blink")
	current_charge = 0
	charge_level = 0
	pitch_factor = 0
	bar_up_pitch_scale = 0.2
	
	
