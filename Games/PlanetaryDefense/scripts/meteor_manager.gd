extends Node

var meteorScene = preload("res://scenes/meteor.tscn")
onready var planetNode: Node2D = get_node("../Planet")

func _ready() -> void:
	randomize()
	_spawn_random_meteor()

func _spawn_random_meteor() -> void:
	var meteorNode: Meteor = meteorScene.instance()
	meteorNode.planet = planetNode
	meteorNode.orbit_angle = rand_range(0, 2 * PI)
	meteorNode.orbit_radius = planetNode.radius * 4
	meteorNode.connect("hit_planet", get_parent(), "_on_meteor_hit_planet")
	meteorNode.connect("hit_shield", get_parent(), "_on_meteor_hit_shield")
	add_child(meteorNode)
		
func _spawn_random_meteors(howMany: int) -> void:
	for i in range(0, howMany):
		_spawn_random_meteor()

func _on_MeteorSpawnTimer_timeout():
	_spawn_random_meteor()
