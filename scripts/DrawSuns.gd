extends TextureRect

onready var camera = $"../../Camera"
onready var stars = $"../Stars"
onready var suns = $"../../Spatial"

func _draw():
	var max_distance = 8
	
	for i in range(suns.get_children().size()):
		var sun1 = suns.get_children()[i]
		var sun1_v = sun1.global_transform.origin
		var sun1_p = camera.unproject_position(sun1_v)
		
		draw_arc(sun1_p, 16, 0, TAU, 12, Color.white, 1.0)
		
		for j in range(suns.get_children().size()):
			if i == j: continue
			var sun2 = suns.get_children()[j]
			var sun2_v = sun2.global_transform.origin
			var sun2_p = camera.unproject_position(sun2_v)
			if sun1_v.distance_to(sun2_v) >= max_distance: continue
			
			draw_line(sun1_p, sun2_p, Color.white, 1.0)

func _ready():
	_generate_sun_hover()

func _process(delta):
	update()
	_move_controls()

func _generate_sun_hover():
	for sun in suns.get_children():
		var position = camera.unproject_position(sun.global_transform.origin)
		var control = Control.new()
		
		$"../Stars".add_child(control)
		control.rect_size = Vector2(16, 16)
		control.rect_position = position - (control.rect_size / 2)
		control.connect("mouse_entered", self, "_sun_hover", [ sun ])
		control.set_meta("sun", sun)
		
func _move_controls():
	for child in stars.get_children():
		child.rect_position = camera.unproject_position(child.get_meta("sun").global_transform.origin) - (child.rect_size / 2)
	
func _sun_hover(sun):
	camera.look(sun.global_transform.origin)
