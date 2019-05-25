extends Node

# demonstrates handling multi-touch input
# touch is also interpreted as mouse clicks/movements, but only 
# the first touch is recognized, and only as BUTTON_LEFT

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch: touch_input(event)
	elif event is InputEventScreenDrag: drag_input(event)
	elif event is InputEventMouseButton: mouse_button(event)
	elif event is InputEventMouseMotion: mouse_motion(event)
		
func touch_input(event: InputEventScreenTouch) -> void:
	print("Touch [%d] %s @ %s" % [event.index, "DOWN" if event.pressed else "UP", event.position])
	
func drag_input(event: InputEventScreenDrag) -> void:
	print("Drag  [%d] @ %s (relative %s)" % [event.index, event.position, event.relative])
	
func mouse_button(event: InputEventMouseButton) -> void:
	print("Click (button: %d) %s @ %s" % [event.button_index, "DOWN" if event.pressed else "UP", event.position])
	
func mouse_motion(event: InputEventMouseMotion) -> void:
	print("Mouse @ %s" % event.position) 