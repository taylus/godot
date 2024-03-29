extends Node2D

class_name Planet

export var radius: float
export var color: Color
export var hit_color: Color = Color(0.7, 0.3, 0.25)
var _current_color: Color = color setget set_current_color
var shield_radius: float
var shield_angle: float
var _shield_radians: float = PI / 3.5
var _shield_line_width: float = 4
var _font: Font

onready var _hit_flash_timer = get_node("HitFlashTimer")

func _ready() -> void:
	_current_color = color
	shield_radius = radius + 20
	
	# https://godotengine.org/qa/7307/getting-default-editor-font-for-draw_string
	var label = Label.new()
	_font = label.get_font("")

func _draw() -> void:
	_draw_planet()
	_draw_shield()
	if OS.is_debug_build(): _draw_debug_info()
	
func _unhandled_input(event) -> void:
	if not (event is InputEventMouseMotion or event is InputEventMouseButton): return
	var localMousePos = to_local(get_viewport().get_mouse_position())
	shield_angle = Math.get_angle(localMousePos)
	update()

func _draw_planet() -> void:
	_draw_circle(Vector2.ZERO, radius, _current_color, true)
	
func _draw_shield() -> void:
	_draw_arc(Vector2.ZERO, shield_radius, get_shield_start_angle(), get_shield_end_angle(), Color.lightblue, false, _shield_line_width)

func get_shield_start_angle() -> float:
	return shield_angle - _shield_radians / 2
	
# wrap the angle measurements around for proper collision detection
func get_shield_start_angle_for_collision() -> float:
	var angle = get_shield_start_angle()
	if angle < 0: angle = (2 * PI) + angle
	return angle
	
func get_shield_end_angle() -> float:
	return shield_angle + _shield_radians / 2
	
# wrap the angle measurements around for proper collision detection
func get_shield_end_angle_for_collision() -> float:
	var angle = get_shield_end_angle()
	if angle > 2 * PI: angle -= 2 * PI
	return angle

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
	_draw_arc(center, radius, 0, 2 * PI, color, filled, width)
	
func _draw_debug_info() -> void:
	var angle_display_radius = shield_radius + 10
	var shield_start_angle = get_shield_start_angle_for_collision()
	var shield_end_angle = get_shield_end_angle_for_collision()
	draw_string(_font, Math.point_on_circle(shield_start_angle, angle_display_radius), str(shield_start_angle), Color.gray)
	draw_string(_font, Math.point_on_circle(shield_end_angle, angle_display_radius), str(shield_end_angle), Color.gray)

func flash(duration: float = 0.8) -> void:
	self._current_color = hit_color
	_hit_flash_timer.stop()
	_hit_flash_timer.start(0.25)
	yield(get_tree().create_timer(duration), "timeout")
	_hit_flash_timer.stop()
	self._current_color = color

func _on_HitFlashTimer_timeout() -> void:
	self._current_color = hit_color if _current_color != hit_color else color
	update()

func set_current_color(value: Color) -> void:
	_current_color = value
	update()