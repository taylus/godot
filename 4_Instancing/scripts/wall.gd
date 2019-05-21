extends Area2D

onready var shape: RectangleShape2D = get_node("CollisionShape2D").shape
var color = Color.lightgreen

func _draw():
	draw_rect(Rect2(-shape.extents, shape.extents * 2), color)

func _on_area_entered(other: Area2D):
	if other.is_in_group("walls"): return
	color = Color.lightcoral
	update()

func _on_area_exited(other: Area2D):
	if other.is_in_group("walls"): return
	color = Color.lightgreen
	update()
