extends StaticBody2D

var hit = false

func _ready():
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count("default")

func collide():
	if hit: return
	hit = true
	$CollisionShape2D.disabled = true
	$Particles2D.emitting = true
	$AnimatedSprite.visible = false
	
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
	
