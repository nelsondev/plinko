extends TextureRect

func _draw():
	var camera = $"../../Camera"
	var points = []
	for child in $"../../Spatial".get_children():
		points.push_back(camera.unproject_position(child.global_transform.origin))
		
	for i in range(points.size()):
		if i >= points.size() - 2: break
		var p1 = points[i]
		var p2 = points[i + 1]
		draw_line(p1, p2, Color.white, 1.0)
	
func _ready():
	update()
