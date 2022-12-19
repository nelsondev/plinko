extends Spatial

onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = 0.15
	timer.connect("timeout", self, "_animate")
	timer.start()
	
func _animate():
	$Ship.rotation.x += 0.101
	$Ship.rotation.y += 0.1
	$Sun.rotation.y += 0.05
