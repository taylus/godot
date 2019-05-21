extends Area2D

export var movement_speed = 4
onready var shape: CircleShape2D = get_node("CollisionShape2D").shape
	
func _draw():
	draw_circle(Vector2.ZERO, shape.radius, Color(0, 0.5, 0.5, 0.5))

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_local_x(-movement_speed)
	elif Input.is_action_pressed("ui_right"):
		move_local_x(movement_speed)
		
	if Input.is_action_pressed("ui_up"):
		move_local_y(-movement_speed)
	elif Input.is_action_pressed("ui_down"):
		move_local_y(movement_speed)