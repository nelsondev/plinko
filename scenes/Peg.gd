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
	
	Game.get_camera().zoom_in(Vector2(0.9, 0.9), 1.0)
	Game.add_hits(1)
	
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
