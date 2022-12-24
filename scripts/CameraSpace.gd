extends Camera

func look(to: Vector3, time = 1.0):
	$Tween.stop_all()
	$Tween.interpolate_property(self, "transform", transform, transform.looking_at(to, Vector3.UP), time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
