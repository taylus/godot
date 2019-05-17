extends TextureRect

const axis_deadzone = 0.1
const button_radius = 19
const button_color = Color(1, 0, 0, 0.7)
const button_positions = {
	a = Vector2(406, 182),
	b = Vector2(444, 147),
	x = Vector2(370, 147),
	y = Vector2(407, 110),
	l1 = Vector2(118, 34),
	r1 = Vector2(412, 34),
	l2 = Vector2(118, 14),
	r2 = Vector2(412, 14),
	l3 = Vector2(190, 226),
	r3 = Vector2(334, 228),
	select = Vector2(212, 114),
	start = Vector2(315, 114),
	up = Vector2(118, 118),
	down = Vector2(120, 166),
	left = Vector2(94, 142),
	right = Vector2(144, 142)
}
var buttons_down = {
	a = false,
	b = false,
	x = false,
	y = false,
	l1 = false,
	r1 = false,
	l2 = false,
	r2 = false,
	l3 = false,
	r3 = false,
	select = false,
	start = false,
	up = false,
	down = false,
	left = false,
	right = false
}

func _ready() -> void:
	Input.connect("joy_connection_changed", self, "gamepad_changed")
	
func gamepad_changed(id, connected) -> void:
	if connected:
		print("Gamepad #", id, " connected")
		if Input.is_joy_known(id):
			print("Recognized Gamepad #", id, " as \"", Input.get_joy_name(id), "\"")
	else:
		print("Gamepad #", id, " disconnected")

func _physics_process(delta) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	if Input.get_connected_joypads().size() == 0: return
	
	print_button_presses()
	handle_analog_sticks()
	handle_buttons()
	update()
	
func print_button_presses() -> void:
	for i in range(JOY_BUTTON_MAX):
		if Input.is_joy_button_pressed(0, i):
			print("Button ", i, " pressed, name = ", Input.get_joy_button_string(i))	

func handle_analog_sticks() -> void:
	var left_analog = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
	#print("Left analog stick: ", left_analog)
	handle_analog_stick(left_analog, $LeftAnalogArrow)
	
	var right_analog = Vector2(Input.get_joy_axis(0, JOY_AXIS_2), Input.get_joy_axis(0, JOY_AXIS_3))
	#print("Right analog stick: ", right_analog)
	handle_analog_stick(right_analog, $RightAnalogArrow)
		
func handle_analog_stick(input: Vector2, arrow: Sprite) -> void:
	if input.length() > axis_deadzone:
		arrow.show()
		arrow.rotation = atan2(input.y, input.x)
		arrow.scale.x = input.length()
	else:
		arrow.hide()
	
func handle_buttons() -> void:
	buttons_down.a = Input.is_joy_button_pressed(0, JOY_BUTTON_0)
	buttons_down.b = Input.is_joy_button_pressed(0, JOY_BUTTON_1)
	buttons_down.x = Input.is_joy_button_pressed(0, JOY_BUTTON_2)
	buttons_down.y = Input.is_joy_button_pressed(0, JOY_BUTTON_3)
	buttons_down.l1 = Input.is_joy_button_pressed(0, JOY_BUTTON_4)
	buttons_down.r1 = Input.is_joy_button_pressed(0, JOY_BUTTON_5)
	buttons_down.l2 = Input.is_joy_button_pressed(0, JOY_BUTTON_6)
	buttons_down.r2 = Input.is_joy_button_pressed(0, JOY_BUTTON_7)
	buttons_down.l3 = Input.is_joy_button_pressed(0, JOY_BUTTON_8)
	buttons_down.r3 = Input.is_joy_button_pressed(0, JOY_BUTTON_9)
	buttons_down.select = Input.is_joy_button_pressed(0, JOY_BUTTON_10)
	buttons_down.start = Input.is_joy_button_pressed(0, JOY_BUTTON_11)
	buttons_down.up = Input.is_joy_button_pressed(0, JOY_BUTTON_12)
	buttons_down.down = Input.is_joy_button_pressed(0, JOY_BUTTON_13)
	buttons_down.left = Input.is_joy_button_pressed(0, JOY_BUTTON_14)
	buttons_down.right = Input.is_joy_button_pressed(0, JOY_BUTTON_15)
	
func _draw() -> void:
	for button in buttons_down:
		if(buttons_down[button]):
			draw_circle(button_positions[button], button_radius, button_color)