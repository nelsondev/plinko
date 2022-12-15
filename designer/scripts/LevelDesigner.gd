extends Node2D

var _tool = ""
var _peg = -1

func _ready():
	var grid = $"CanvasLayer/Container/Grid"
	
	for child in grid.get_children():
		child.connect("_input_event", self, "_on_grid_input_event")

func _get_grid():
	return $"CanvasLayer/Container/Grid"
func _get_grid_panel():
	return $"CanvasLayer/Panel/Grid"
func _get_peg_icon():
	return $"CanvasLayer/Panel/Pegs/ItemList".get_item_icon(_peg)
func _get_pan():
	return $"CanvasLayer/Pan"

func _on_ButtonBrush_pressed():
	_tool = "brush"
	Input.set_custom_mouse_cursor($"CanvasLayer/Panel/Tools/ButtonBrush".icon)
	_get_pan().mouse_filter = 2

func _on_ButtonEraser_pressed():
	_tool = "eraser"
	Input.set_custom_mouse_cursor($"CanvasLayer/Panel/Tools/ButtonEraser".icon)
	
	_get_pan().mouse_filter = 2

func _on_ButtonFill_pressed():
	_tool = "fill"
	Input.set_custom_mouse_cursor($"CanvasLayer/Panel/Tools/ButtonFill".icon)
	_get_pan().mouse_filter = 2

func _on_ButtonPan_pressed():
	_tool = "pan"
	Input.set_custom_mouse_cursor($"CanvasLayer/Panel/Tools/ButtonPan".icon)
	_get_pan().mouse_filter = 1

func _on_ItemList_item_selected(index):
	_peg = index

func _on_Grid_mouse_enter(area: Area2D):
	if Input.is_mouse_button_pressed(1):
		if _tool == "brush":
			area.get_node("Sprite").texture = _get_peg_icon()
		elif _tool == "eraser":
			area.get_node("Sprite").texture = null
func _on_Grid_input_event(viewport, event, shape_idx, area):
	if event is InputEventMouseButton and event.pressed:
		if _tool == "brush":
			area.get_node("Sprite").texture = _get_peg_icon()
		elif _tool == "eraser":
			area.get_node("Sprite").texture = null
func _on_Grid_ready():
	var grid = _get_grid().SIZE_GRID
	_get_grid_panel().get_node("HSliderX").value = grid.x
	_get_grid_panel().get_node("HSliderY").value = grid.y
	_get_grid_panel().get_node("HSliderX/Label").text = "x: " + str(grid.x)
	_get_grid_panel().get_node("HSliderY/Label").text = "y: " + str(grid.y)
	
	$"CanvasLayer/Panel/Zoom/LineEditZoom".text = str(_get_grid().rect_scale.x * 100) + "%"

func _on_HSliderX_value_changed(value):
	_get_grid().SIZE_GRID.x = value
	_get_grid_panel().get_node("HSliderX/Label").text = "x: " + str(value)

func _on_HSliderY_value_changed(value):
	_get_grid().SIZE_GRID.y = value
	_get_grid_panel().get_node("HSliderY/Label").text = "y: " + str(value)

func _on_ButtonGenerate_pressed():
	_get_grid()._generate()

func _on_LineEditZoom_text_entered(new_text):
	var parsed = int(new_text)
	_get_grid().rect_scale = Vector2(parsed / 100.0, parsed / 100.0)
	$"CanvasLayer/Panel/Zoom/LineEditZoom".text = str(round(_get_grid().rect_scale.x * 100)) + "%"

var drag = null
func _on_Pan_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			drag = get_global_mouse_position() - _get_grid().rect_position
		else:
			drag = null
	if event is InputEventMouseMotion and drag != null:
		_get_grid().rect_position = get_global_mouse_position() - drag
