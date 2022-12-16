extends Control

export var SIZE_PEG: Vector2
export var SIZE_GRID: Vector2

func _draw():
	var grid = _create_grid()
	# Draw lines
	for position in grid:
		draw_line(Vector2(position["position"].x - 4, position["position"].y), Vector2(position["position"].x + 4, position["position"].y), Color.white)
		draw_line(Vector2(position["position"].x, position["position"].y - 4), Vector2(position["position"].x, position["position"].y + 4), Color.white)

func _ready():
	_generate()

func _create_grid():
	var grid = []
	for y_size in range(SIZE_GRID.y):
		for x_size in range(SIZE_GRID.x): 
			grid.push_back({
				"coords": Vector2(x_size, y_size),
				"position": Vector2((x_size * SIZE_PEG.x) + (SIZE_PEG.x / 2), (y_size * SIZE_PEG.y) + (SIZE_PEG.y / 2))
			})
	return grid
	
func _create_areas():
	var grid = _create_grid()
	for position in grid:
		var area = Area2D.new()
		var shape = CollisionShape2D.new()
		var rectangle = RectangleShape2D.new()
		var sprite = Sprite.new()
			
		add_child(area)
		area.add_child(shape)
		area.add_child(sprite)
		
		sprite.name = "Sprite"
		shape.shape = rectangle
		rectangle.extents = SIZE_PEG / 2
		
		area.position = position["position"]
		area.input_pickable = true
		area.set_collision_mask_bit(0, true)
		area.set_collision_layer_bit(0, true)
		area.connect("mouse_entered", $"/root/LevelDesigner", "_on_Grid_mouse_enter", [ area ])
		area.connect("input_event", $"/root/LevelDesigner", "_on_Grid_input_event", [ area ])
		area.set_meta("position", position["coords"])
		area.set_meta("peg", -1)

func _generate():
	var label = $"../../LabelLoading"
	
	label.text = "Loading... Deleting old grid"
	yield(VisualServer, "frame_post_draw")
	for child in get_children(): child.queue_free()
	
	label.text = "Loading... Calculating size"
	yield(VisualServer, "frame_post_draw")
	rect_size = SIZE_GRID * SIZE_PEG
	rect_pivot_offset = rect_size / 2
	rect_position = (get_parent().rect_size / 2) - (rect_size / 2)
	
	label.text = "Loading... Drawing grid"
	yield(VisualServer, "frame_post_draw")
	update()
	
	label.text = "Loading... Creating level surface"
	yield(VisualServer, "frame_post_draw")
	_create_areas()
	
	label.text = ""
