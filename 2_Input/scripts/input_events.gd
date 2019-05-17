extends Sprite

const speed: int = 3
var mouse_button_left_down: bool = false

# demonstrates handling keyboard and mouse input via  events
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		keyboard_input(event)
	elif event is InputEventMouseButton:
		mouse_button(event)
	elif event is InputEventMouseMotion:
		mouse_motion(event)

func keyboard_input(event: InputEventKey) -> void:
	if event.scancode == KEY_ESCAPE:
		get_tree().quit()
		
	if event.scancode == KEY_A:
		position.x -= speed
	elif event.scancode == KEY_D:
		position.x += speed
		
	if event.scancode == KEY_W:
		position.y -= speed
	elif event.scancode == KEY_S:
		position.y += speed

func mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index != BUTTON_LEFT: return
	mouse_button_left_down = event.pressed
	if mouse_button_left_down:
		position = get_viewport().get_mouse_position()
		
func mouse_motion(event: InputEventMouseMotion) -> void:
	if mouse_button_left_down:
		translate(event.relative)