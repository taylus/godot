extends Node2D

var ball_scene = preload("res://scenes/ball.tscn")
var wall_scene = preload("res://scenes/wall.tscn")

const num_walls = 20

func _ready():
	randomize() # seed the rng
	spawn_walls()
	spawn_player()
		
func spawn_player() -> void:
	var ball = ball_scene.instance()
	ball.position = center_of(get_viewport())
	add_child(ball)
	
func spawn_walls() -> void:
	for i in range(num_walls):
		spawn_wall()
		
func spawn_wall() -> void:
	var wall = wall_scene.instance()
	wall.position = random_point_in(get_viewport())
	add_child(wall)
		
func random_point_in(viewport: Viewport) -> Vector2:
	return Vector2(rand_range(0, viewport.size.x), rand_range(0, viewport.size.y))
	
func center_of(viewport: Viewport) -> Vector2:
	return Vector2(viewport.size.x / 2, viewport.size.y / 2)
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()