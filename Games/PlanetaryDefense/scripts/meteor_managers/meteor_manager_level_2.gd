extends Node2D

var meteorScene = preload("res://scenes/bullet_meteor.tscn")
onready var planetNode: Node2D = get_node("../Planet")

func _ready() -> void:
	randomize()
	_spawn_random_meteor()

func _spawn_random_meteor() -> void:
	var meteorNode: BulletMeteor = meteorScene.instance()
	meteorNode.planet = planetNode
	meteorNode.radius = 6
	meteorNode.orbit_angle = rand_range(0, 2 * PI)
	meteorNode.orbit_radius = _get_meteor_spawn_radius(meteorNode)
	meteorNode.connect("hit_planet", get_parent(), "_on_meteor_hit_planet")
	meteorNode.connect("hit_shield", get_parent(), "_on_meteor_hit_shield")
	add_child(meteorNode)
	
func _get_meteor_spawn_radius(meteor: Meteor) -> float:
	var viewportRect = get_viewport_rect()
	return (max(viewportRect.end.x, viewportRect.end.y) / 2) + meteor.radius
		
func _spawn_random_meteors(howMany: int) -> void:
	for i in range(0, howMany):
		_spawn_random_meteor()

func _on_MeteorSpawnTimer_timeout():
	_spawn_random_meteor()
