extends Area2D

var fade = false

func _ready():
	var ships = get_node("../../../Ships")
	ships.modulate.a = 0.0

func _process(delta):
	if fade: 
		var parent = get_node("../../")
		var camera = get_node("../../Camera2D")
		var ships = get_node("../../../Ships")
		
		parent.modulate.a = lerp(parent.modulate.a, 0.3, 0.05)
		ships.modulate.a = lerp(ships.modulate.a, 1.0, 0.05)
		camera.zoom = camera.zoom.linear_interpolate(Vector2(1.2, 1.2), 0.1)

func _on_End_body_entered(body):
	if body.is_in_group("ball"):
		fade = true
		body.sleeping = true
		body.visible = false
