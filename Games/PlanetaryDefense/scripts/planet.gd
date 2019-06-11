tool
extends Node2D

export var radius: float
var angle: float
var _shield_radians: float = PI / 3.5
var _shield_line_width: float = 4

func _draw() -> void:
	_draw_planet()
	_draw_shield()
	
func _unhandled_input(event) -> void:
	if not event is InputEventMouseMotion: return
	var localMousePos = to_local(get_viewport().get_mouse_position())
	angle = get_angle(localMousePos)
	update()

func _draw_planet() -> void:
	_draw_circle(Vector2.ZERO, radius, Color.darkkhaki, true)
	
func _draw_shield() -> void:
	var shield_radius = radius + 20
	var start_angle = angle - _shield_radians / 2
	var end_angle = angle + _shield_radians / 2
	_draw_arc(Vector2.ZERO, shield_radius, start_angle, end_angle, Color.lightblue, false, _shield_line_width)

func _draw_arc(center: Vector2, radius: float, angle_from: float, angle_to: float, 
               color: Color, filled: bool = false, width: float = 1) -> void:
	if radius <= 0: return
	var num_points = radius
	var points = PoolVector2Array()
	
	for i in range(0, num_points + 1):
		var angle: float = angle_from + i * (angle_to - angle_from) / num_points
		points.push_back(center + Vector2(cos(angle), -sin(angle)) * radius)
		
	if filled:
		draw_polygon(points, [color])
	else:
		draw_polyline(points, color, width)
		
func _draw_circle(center: Vector2, radius: float, color: Color, filled: bool = false, width: float = 1) -> void:
	_draw_arc(center, radius, 0, 2 * PI, color, width)
		
# returns the angle (in radians) corresponding to the given point on the circle
func get_angle(point: Vector2) -> float:
	var angle = atan2(-point.y, point.x)
	if angle <= 0: angle = (2 * PI) + angle
	return angle
	
# returns the point on the circle corresponding to the given angle
func get_point(angle: float) -> Vector2:
	return Vector2(cos(angle), -sin(angle)) * radius