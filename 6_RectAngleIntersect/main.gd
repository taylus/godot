extends Node2D

onready var _rect = $Rectangle
var _mouse_position: Vector2
var _font: Font
const _circle_radius: float = 240.0

func _ready() -> void:
	_center_on_screen(_rect)
	_font = _load_font()

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion: return
	_mouse_position = event.position
	update()
	
func _draw() -> void:
	draw_line(_rect.center, _mouse_position, Color.gray, 1)
	_draw_coords(_mouse_position)
	_draw_coords(_rect.center)
	_draw_rect_coords(_rect)
	
	var angle = _get_angle(_mouse_position - _rect.center)
	_draw_arc(_rect.center, _circle_radius, 0, angle, Color.limegreen)
	
	var angle_display_pos = _rect.center + Vector2(60, -60)
	draw_string(_font, angle_display_pos, "angle = %s" % angle)
	
	var rect_intersect_pos = _get_point_on_rect_at_angle(_rect, angle)
	_draw_coords(rect_intersect_pos)

func _center_on_screen(rect: Rectangle) -> void:
	var viewport = get_viewport()
	rect.position = (viewport.size / 2) - (Vector2(rect.width, rect.height) / 2)
	
# https://godotengine.org/qa/7307/getting-default-editor-font-for-draw_string
func _load_font() -> Font:
	var label = Label.new()
	return label.get_font("")
	
func _draw_coords(coordinates: Vector2) -> void:
	draw_circle(coordinates, 3, Color.white)
	draw_string(_font, coordinates, str(coordinates))
	
func _draw_rect_coords(rect: Rectangle) -> void:
	_draw_coords(rect.position)
	_draw_coords(Vector2(rect.position.x + rect.width, rect.position.y))
	_draw_coords(Vector2(rect.position.x, rect.position.y + rect.height))
	_draw_coords(Vector2(rect.position.x + rect.width, rect.position.y + rect.height))
	
func _draw_arc(center: Vector2, radius: float, angle_from: float, angle_to: float, color: Color, width: float = 1) -> void:
	if radius <= 0: return
	var num_points = radius
	var points = PoolVector2Array()
	
	for i in range(0, num_points + 1):
		var angle: float = angle_from + i * (angle_to - angle_from) / num_points
		points.push_back(center + Vector2(cos(angle), -sin(angle)) * radius)
		
	draw_polyline(points, color, width)
	
# returns the angle (in radians) of the given point on the unit circle
# returns angle in range [0 - 2*PI] rather than [-PI - PI]
func _get_angle(point: Vector2) -> float:
	var angle = atan2(-point.y, point.x)
	if angle <= 0: angle = (2 * PI) + angle
	return angle
	
# returns the point (x, y) on the given rectangle at which a line extending from
# the given angle intersects (so like _get_angle, but for rects instead of circles)
# reference: https://stackoverflow.com/a/31886696/7512368
func _get_point_on_rect_at_angle(rect: Rectangle, angle: float) -> Vector2:
	while angle < -PI: angle += PI * 2
	while angle > PI: angle -= PI * 2
	
	var rect_atan = atan2(rect.height, rect.width)
	var tan_angle = tan(angle)
	
	var region: int
	if (angle > -rect_atan) and (angle <= rect_atan): region = 1
	elif (angle > rect_atan) and (angle <= (PI - rect_atan)): region = 2
	elif (angle > (PI - rect_atan)) or (angle <= -(PI - rect_atan)): region = 3
	else: region = 4
	
	var x_factor = 1
	var y_factor = 1
	if region == 1 or region == 2:
		y_factor = -1
	elif region == 3 or region == 4:
		x_factor = -1
	
	var edge_point = Vector2(rect.width / 2, rect.height / 2)
	if region == 1 or region == 3:
		edge_point.x += x_factor * (rect.width / 2)
		edge_point.y += y_factor * (rect.width / 2) * tan_angle
	else:
		edge_point.x += x_factor * (rect.height / (2 * tan_angle))
		edge_point.y += y_factor * (rect.height / 2)
		
	return rect.position + edge_point