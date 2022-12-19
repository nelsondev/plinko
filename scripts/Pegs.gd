extends Node2D

export(String, FILE, "*.json") var LEVEL_JSON
export var POSITIONS_NODE: NodePath

export var PEGS_SCENES = [
	preload("res://scenes/Ball.tscn"),
	preload("res://scenes/Peg.tscn")
]

var level_data: Array = []
var positions_node: PegglePositions

func _ready():
	positions_node = get_node(POSITIONS_NODE)
	
	_load_json()
	_load_pegs()
	
func _load_json():
	var file = File.new()
	file.open(LEVEL_JSON, File.READ)
	var json = file.get_as_text()
	level_data = JSON.parse(json).result as Array

func _load_pegs():
	for data in level_data:
		var position = positions_node.find(Vector2(data["position"]["x"], data["position"]["y"]))
		var PEG = PEGS_SCENES[data["peg"]]
		var peg = PEG.instance()
		peg.transform.origin = position
		add_child(peg)
