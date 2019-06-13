extends Node2D

class_name Meteor

signal hit_planet
signal hit_shield

export var radius: float
var orbit_radius: float setget set_orbit_radius
var orbit_angle: float setget set_orbit_angle
const BASE_FALL_SPEED: float = 30.0  # pixels/sec
var planet: Planet

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color.saddlebrown)

func _physics_process(delta: float) -> void:
	_fall(delta)
	
func _fall(delta: float) -> void:
	orbit_radius -= (_get_fall_speed() * delta)
	position = Math.point_on_circle(orbit_angle, orbit_radius, planet.position)
	
	if _hit_shield():
		emit_signal("hit_shield", self)
		
	if _hit_planet():
		emit_signal("hit_planet", self)
		
# calculate fall speed in pixels/sec based on size
func _get_fall_speed() -> float:
	#if radius == 0: return float(0)
	return BASE_FALL_SPEED + ((10 * BASE_FALL_SPEED) / radius)
		
func _hit_shield() -> bool:
	var fudge_factor = (radius * 0.005)
	var shield_start_angle = planet.get_shield_start_angle_for_collision() - fudge_factor
	var shield_end_angle = planet.get_shield_end_angle_for_collision() + fudge_factor
	var meteor_angle = orbit_angle
	
	# adjust if the shield is spanning the point where the angles wrap around (2 PI -> 0)
	if shield_start_angle > shield_end_angle:
		shield_end_angle += 2 * PI
		if meteor_angle >= 0 and meteor_angle <= PI:
			meteor_angle += 2 * PI # adjust small meteor angles
		
	return orbit_radius < planet.shield_radius + self.radius \
		and meteor_angle >= shield_start_angle \
		and meteor_angle <= shield_end_angle
		
func _hit_planet() -> bool:
	return orbit_radius < planet.radius + self.radius
	
func set_orbit_radius(value: float) -> void:
	orbit_radius = value
	position = Math.point_on_circle(orbit_angle, orbit_radius, planet.position)
	
func set_orbit_angle(value: float) -> void:
	orbit_angle = value
	position = Math.point_on_circle(orbit_angle, orbit_radius, planet.position)