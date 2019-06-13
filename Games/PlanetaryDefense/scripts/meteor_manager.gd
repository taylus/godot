extends Node

var meteorScene = preload("res://scenes/meteor.tscn")
onready var planetNode: Node2D = get_node("../Planet")

func _ready() -> void:
	randomize()
	_spawn_meteor()

func _spawn_meteor() -> void:
	for i in range(0, 359):
		var meteorNode: Meteor = meteorScene.instance()
		#meteorNode.orbit_angle = rand_range(0, 2 * PI)
		meteorNode.orbit_angle = deg2rad(i)
		meteorNode.orbit_radius = planetNode.radius * 1.8
		meteorNode.planet = planetNode
		meteorNode.connect("hit_planet", get_parent(), "_on_meteor_hit_planet")
		meteorNode.connect("hit_shield", get_parent(), "_on_meteor_hit_shield")
		add_child(meteorNode)