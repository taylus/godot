extends Node2D

onready var planetNode: Node2D = get_node("Planet")

func _ready() -> void:
	get_tree().get_root().connect("size_changed", self, "_on_window_size_changed")
	_center(planetNode)
	if OS.is_debug_build(): _show_debug_elements()

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

func _show_debug_elements() -> void:
	_show_level_name("Debug/LevelNameDisplay")
	_show_back_button("Debug/BackButton")

func _show_level_name(labelName: String) -> void:
	var label: Label = get_node_or_null(labelName)
	if label == null: return
	label.text = self.name
	label.show()
	
func _show_back_button(buttonName: String) -> void:
	var button: Button = get_node_or_null(buttonName)
	if button == null: return
	button.show()
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
