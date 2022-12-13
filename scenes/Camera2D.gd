extends Camera2D

export var FOLLOW: NodePath

onready var start = transform.origin

func _process(delta):
	var node = get_node(FOLLOW)
	var distance = 8
	var middle = start + (start.direction_to(node.transform.origin) * distance)
	transform.origin = middle
