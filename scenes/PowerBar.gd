extends Panel

var panel_original_rect_y

func _ready():
	panel_original_rect_y = $Panel.rect_size.y
	Game.connect("charge_added", self, "_animate")
	
func _animate():
	$AnimationPlayer.play("RESET")
	$Panel.rect_size.y = panel_original_rect_y - (panel_original_rect_y * (Game.charge / 10.0))
	$AnimationPlayer.play("wiggle")
