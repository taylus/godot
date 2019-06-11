tool
extends CanvasItem

class_name Math
		
# returns the angle (in radians) corresponding to the given point on the circle
static func get_angle(point: Vector2) -> float:
	var angle = atan2(-point.y, point.x)
	if angle <= 0: angle = (2 * PI) + angle
	return angle
	
# returns the point on the circle corresponding to the given angle
static func point_on_circle(angle: float, radius: float, center: Vector2 = Vector2.ZERO) -> Vector2:
	return center + Vector2(cos(angle), -sin(angle)) * radius