extends Node2D

class_name Touch2D

export var radius: float
export var pressed_color: Color = Color(0, 0.75, 0)
export var released_color: Color = Color(0.75, 0, 0)
export var line_color: Color = Color.white

var pressed: bool

var _color: Color
var _pressed_at: Vector2

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, _color)
	draw_line(to_local(_pressed_at), Vector2.ZERO, line_color)
	
func press(position: Vector2) -> void:
	pressed = true
	_color = pressed_color
	_pressed_at = position
	self.position = position
	show()
	update()
	
func move(position: Vector2) -> void:
	self.position = position
	update()
	
func release(position: Vector2) -> void:
	pressed = false
	_color = released_color
	self.position = position
	update()