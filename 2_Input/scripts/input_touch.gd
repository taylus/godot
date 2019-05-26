extends Node

# demonstrates handling multi-touch input
# touch is also interpreted as mouse clicks/movements, but only 
# the first touch is recognized, and only as BUTTON_LEFT

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch: _touch_input(event)
	elif event is InputEventScreenDrag: _drag_input(event)
	elif event is InputEventMouseButton: _mouse_button(event)
	elif event is InputEventMouseMotion: _mouse_motion(event)
		
func _touch_input(event: InputEventScreenTouch) -> void:
	print("Touch [%d] %s @ %s" % [event.index, "DOWN" if event.pressed else "UP", event.position])
	if event.pressed:
		_press(event.position, event.index)
	else:
		_release(event.position, event.index)
	
func _drag_input(event: InputEventScreenDrag) -> void:
	print("Drag  [%d] @ %s (relative %s)" % [event.index, event.position, event.relative])
	_drag(event.position, event.index)
	
func _mouse_button(event: InputEventMouseButton) -> void:
	print("Click (button: %d) %s @ %s" % [event.button_index, "DOWN" if event.pressed else "UP", event.position])
	if event.pressed:
		_press(event.position)
	else:
		_release(event.position)
	
func _mouse_motion(event: InputEventMouseMotion) -> void:
	print("Mouse @ %s" % event.position)
	_drag(event.position)

func _press(position: Vector2, index: int = 0) -> void:
	var touch_circle = _get_touch_display(index)
	touch_circle.press(position)
		
func _release(position: Vector2, index: int = 0) -> void:
	var touch_circle = _get_touch_display(index)
	touch_circle.release(position)
	
func _drag(position: Vector2, index: int = 0) -> void:
	var touch_circle = _get_touch_display(index)
	if touch_circle.pressed:
		touch_circle.move(position)

func _get_touch_display(index: int = 0) -> Touch2D:
	var touch_displays = get_node_or_null("TouchDisplays")
	if touch_displays == null || index >= touch_displays.get_child_count():
		push_warning("No touch display found for index #%d" % index)
		return null
	return touch_displays.get_children()[index]

func _on_ClearInputsButton_pressed():
	var touch_displays = get_node_or_null("TouchDisplays")
	if touch_displays == null: return
	for touch_display in get_node("TouchDisplays").get_children():
		touch_display.hide()