extends Sprite

const speed: int = 6

# demonstrates handling keyboard and mouse input via polling
func _physics_process(delta) -> void:
	if Input.is_action_pressed("ui_left"):
		position.x -= speed
	elif Input.is_action_pressed("ui_right"):
		position.x += speed
		
	if Input.is_action_pressed("ui_up"):
		position.y -= speed
	elif Input.is_action_pressed("ui_down"):
		position.y += speed
		
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		position = get_viewport().get_mouse_position()