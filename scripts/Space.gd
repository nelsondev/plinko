extends Spatial

func _ready():
	var look = Vector3.ZERO

	for child in $Spatial.get_children():
		look += child.global_transform.origin

	look /= $Spatial.get_child_count()

	$Camera.look(look, 0)
	
func _process(delta):
	if Input.is_action_just_released("ui_designer_zoom_up"):
		$Camera.fov = lerp($Camera.fov, 0, 0.1)
	if Input.is_action_just_released("ui_designer_zoom_down"):
		$Camera.fov = lerp($Camera.fov, 179, 0.05)
