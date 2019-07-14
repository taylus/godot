tool
extends Node2D

class_name Rectangle

export var width: float
export var height: float
export var color: Color
export var filled: bool

var center setget ,center_get
var size setget ,size_get

func _draw():
	var rect = Rect2(0, 0, width, height)
	draw_rect(rect, color, filled)
	
func size_get() -> Vector2:
	return Vector2(width, height)
	
func center_get() -> Vector2:
	return position + (size_get() / 2)