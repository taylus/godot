extends Sprite

const speed: int = 3

# demonstrates handling keyboard and mouse input via polling
func _physics_process(delta) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://scenes/gamepad.tscn")
	
	if Input.is_key_pressed(KEY_A):
		position.x -= speed
	elif Input.is_key_pressed(KEY_D):
		position.x += speed
		
	if Input.is_key_pressed(KEY_W):
		position.y -= speed
	elif Input.is_key_pressed(KEY_S):
		position.y += speed
		
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		position = get_viewport().get_mouse_position()