extends Camera2D

export var FOLLOW: NodePath

onready var start = transform.origin
onready var zoom_timer = Timer.new()

var zoom_to = null
var is_zoomed = false

func _ready():
	add_child(zoom_timer)
	zoom_timer.connect("timeout", self, "_stop_zoom")

func _process(delta):
	var node = get_node(FOLLOW)
	var distance = 12
	var middle = start + (start.direction_to(node.transform.origin) * distance)
	transform.origin = middle
	
	if is_zoomed:
		zoom = zoom.linear_interpolate(zoom_to, 0.1)
	else:
		zoom = zoom.linear_interpolate(Vector2(1.1, 1.1), 0.1)

func zoom_in(amount, duration):
	zoom_timer.wait_time = duration
	zoom_timer.start()
	is_zoomed = true
	zoom_to = amount
	
func _stop_zoom():
	is_zoomed = false
