extends Spatial

onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = 0.15
	timer.connect("timeout", self, "_animate")
	timer.start()
	
func _animate():
	$MeshInstance.rotation.x += 0.15
	$MeshInstance.rotation.y += 0.15
