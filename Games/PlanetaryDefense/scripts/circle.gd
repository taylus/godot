tool
extends Node2D

const LINE_WIDTH: float = 2.0
export var radius: float
var _font: Font

func _ready() -> void:
	# https://godotengine.org/qa/7307/getting-default-editor-font-for-draw_string
	var label = Label.new()
	_font = label.get_font("")

func _draw() -> void:
	_draw_circle(Vector2.ZERO, radius, Color.white, LINE_WIDTH)
	
	var localMousePos = to_local(get_viewport().get_mouse_position())
	var angle = get_angle(localMousePos)
	_draw_arc(Vector2.ZERO, radius, 0, angle, Color.limegreen, LINE_WIDTH * 2)
	draw_line(Vector2.ZERO, localMousePos, Color.white, LINE_WIDTH)
	draw_string(_font, get_point(angle) + Vector2(10, 0), str(angle), Color.gray)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion: update()
	
func _draw_arc(center: Vector2, radius: float, angle_from: float, angle_to: float, color: Color, width: float = 1) -> void:
	if radius <= 0: return
	var num_points = radius
	var points = PoolVector2Array()
	
	for i in range(0, num_points + 1):
		var angle: float = angle_from + i * (angle_to - angle_from) / num_points
		points.push_back(center + Vector2(cos(angle), -sin(angle)) * radius)
		
	draw_polyline(points, color, width)
		
func _draw_circle(center: Vector2, radius: float, color: Color, width: float = 1, draw_guides: bool = true) -> void:
	_draw_arc(center, radius, 0, 2 * PI, color, width)
	if draw_guides:
		draw_line(Vector2.ZERO, Vector2(radius, 0), Color.white, width)
		draw_line(Vector2.ZERO, Vector2(0, radius), Color.white, width)
		draw_line(Vector2.ZERO, Vector2(-radius, 0), Color.white, width)
		draw_line(Vector2.ZERO, Vector2(0, -radius), Color.white, width)
		# magic number adjustments tied to font and text size, draw_string starting at upper left, etc
		draw_string(_font, Vector2(center.x + radius + 10, 4), "0")
		draw_string(_font, Vector2(-18, center.y - radius - 12), "PI / 2")
		draw_string(_font, Vector2(center.x - radius - 24, 4), "PI")
		draw_string(_font, Vector2(-24, center.y + radius + 22), "3 PI / 2")
		
# returns the angle (in radians) corresponding to the given point on the circle
func get_angle(point: Vector2) -> float:
	var angle = atan2(-point.y, point.x)
	if angle <= 0: angle = (2 * PI) + angle
	return angle
	
# returns the point on the circle corresponding to the given angle
func get_point(angle: float) -> Vector2:
	return Vector2(cos(angle), -sin(angle)) * radius