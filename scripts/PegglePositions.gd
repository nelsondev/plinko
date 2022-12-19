extends Node2D
class_name PegglePositions

export var WIDTH = 21

func _ready():
	var y = -1
	var x = -1
	for i in get_child_count():
		x += 1
		if x % WIDTH == 0: 
			x = 0
			y += 1
		var position = Vector2(x, y)
		var child = get_child(i)
		child.set_meta("position", position)
		
func find(position: Vector2):
	for child in get_children():
		if child.get_meta("position") == position:
			return child.transform.origin
