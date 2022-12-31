extends Node2D

signal turn_over

onready var Pegs = get_node("/root/MainGame/Peggle/Pegs")
onready var PowerBar = get_node("/root/MainGame/Screen/Screen/PowerBarPanel/PowerBar")
onready var PowerSideBar = get_node("/root/MainGame/Screen/Screen/PowerBarPanel/SideBar")
onready var PowerSideBarAnim = get_node("/root/MainGame/Screen/Screen/PowerBarPanel/SideBar/Blinker")
onready var Bounds = get_node("/root/MainGame/Peggle/OutOfBounds")

func get_root(): return get_tree().current_scene

func _ready():
	Bounds.connect("body_exited", self, "_out_of_bounds")


func _out_of_bounds(body):
	emit_signal("turn_over")
	_next_turn()

func _next_turn():
	Pegs._load_ball()
	Game.charge = 0
	
