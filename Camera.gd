extends Node2D

func move_to_center():
	$Camera2D.transform.origin = $Position2DCenter.transform.origin
	$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(1.8, 1.8), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
func move_to_peggle():
	$Camera2D.transform.origin = $Position2DPeggle.transform.origin
	$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(1, 1), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
