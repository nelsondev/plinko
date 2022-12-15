extends RigidBody2D
class_name Ball

export var GHOST: PackedScene

export var VELOCITY: int = 200

onready var timer = Timer.new()

func _ready():
	sleeping = true
	contact_monitor = true
	contacts_reported = 5
		
	add_child(timer)
	timer.connect("timeout", self, "_create_ghost")
	timer.one_shot = false
	timer.wait_time = 0.1
	timer.start()
		
	update()
	
func _draw():
	draw_circle(Vector2.ZERO, 5, Color("#cbdbfc"))
	
func _process(delta):
	_check_collide()
	print(Game.charge)
	$Ball.frame = Game.charge
	$Light.visible = Game.charge >= 1
	$BallFullyCharged.visible = Game.charge >= 3

# Shoot da ball
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		sleeping = false
		apply_central_impulse(VELOCITY * global_position.direction_to(get_global_mouse_position()))

# Create those physics simulated balls
func _create_ghost():
	var ball = GHOST.instance() as RigidBody2D
	
	ball.mass = mass
	ball.weight = weight
	ball.physics_material_override = physics_material_override
	ball.gravity_scale = gravity_scale
	ball.transform.origin = Vector2.ZERO
	ball.apply_central_impulse(VELOCITY * global_position.direction_to(get_global_mouse_position()))
	
	add_child(ball)

# Check collision with things like pegs
func _check_collide():
	var colliding_bodys = get_colliding_bodies()
	for body in colliding_bodys: 
		if body.is_in_group("collidable"):
			body.collide()
