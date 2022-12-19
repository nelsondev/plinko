extends StaticBody2D

var hit = false

func _ready():
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count("default")

func collide():
	if hit: return
	hit = true
	$CollisionShape2D.disabled = true
	$AnimatedSprite.visible = false
	
	Game.add_charge(1)
	
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
