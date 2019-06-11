tool
extends Node2D

class_name Meteor

signal hit_planet
signal hit_shield

export var radius: float
var orbit_radius: float
var orbit_angle: float
const FALL_SPEED: float = 40.0	# pixels/sec
var planet: Planet

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color.saddlebrown)

func _physics_process(delta: float) -> void:
	_fall(delta)
	
func _fall(delta: float) -> void:
	orbit_radius = orbit_radius - (FALL_SPEED * delta)
	position = Math.point_on_circle(orbit_angle, orbit_radius, planet.position)
	
	if _hit_shield():
		emit_signal("hit_shield", self)
		
	if _hit_planet():
		emit_signal("hit_planet", self)
		
func _hit_shield() -> bool:
	var min_angle = min(planet.get_shield_start_angle(), planet.get_shield_end_angle())
	var max_angle = max(planet.get_shield_start_angle(), planet.get_shield_end_angle())
	return orbit_radius < planet.shield_radius + self.radius \
		and orbit_angle >= min_angle \
		and orbit_angle <= max_angle
		
func _hit_planet() -> bool:
	return orbit_radius < planet.radius + self.radius