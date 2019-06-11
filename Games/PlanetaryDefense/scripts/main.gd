extends Node2D

var meteorScene = preload("res://scenes/meteor.tscn")
onready var planetNode: Node2D = get_node("Planet")

func _ready() -> void:
	randomize()
	
	get_tree().get_root().connect("size_changed", self, "_on_window_size_changed")
	_center(planetNode)
	
	# TODO: have a meteor manager do this
	_spawn_meteor()

func _center(node: Node2D, rect: Rect2 = get_viewport_rect()) -> void:
	node.position = _center_of(rect)

func _on_window_size_changed() -> void:
	print(get_viewport_rect())
	planetNode.position = _center_of(get_viewport_rect())
	
func _center_of(rect: Rect2) -> Vector2:
	return Vector2((rect.position.x + rect.end.x / 2),
	               (rect.position.y + rect.end.y / 2))
				
func _spawn_meteor() -> void:
	for i in range(0, 359):
		var meteorNode: Meteor = meteorScene.instance()
		#meteorNode.orbit_angle = rand_range(0, 2 * PI)
		meteorNode.orbit_angle = deg2rad(i)
		meteorNode.orbit_radius = planetNode.radius * 1.8
		meteorNode.planet = planetNode
		meteorNode.connect("hit_planet", self, "_on_meteor_hit_planet")
		meteorNode.connect("hit_shield", self, "_on_meteor_hit_shield")
		add_child(meteorNode)
	
func _on_meteor_hit_planet(meteor: Meteor) -> void:
	meteor.queue_free()
	
func _on_meteor_hit_shield(meteor: Meteor) -> void:
	meteor.queue_free()
