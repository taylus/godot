extends Node2D

onready var planetNode: Node2D = get_node("Planet")

func _ready() -> void:
	get_tree().get_root().connect("size_changed", self, "_on_window_size_changed")
	_center(planetNode)

func _center(node: Node2D, rect: Rect2 = get_viewport_rect()) -> void:
	node.position = _center_of(rect)

func _on_window_size_changed() -> void:
	print(get_viewport_rect())
	planetNode.position = _center_of(get_viewport_rect())
	
func _center_of(rect: Rect2) -> Vector2:
	return Vector2((rect.position.x + rect.end.x / 2),
	               (rect.position.y + rect.end.y / 2))
				
func _on_meteor_hit_planet(meteor: Meteor) -> void:
	planetNode.flash()
	meteor.queue_free()
	
func _on_meteor_hit_shield(meteor: Meteor) -> void:
	meteor.queue_free()
