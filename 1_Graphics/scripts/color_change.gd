extends Sprite

export var colorChangeMs = 300    # change colors every this many milliseconds
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.connect("timeout", self, "tick")
	timer.wait_time = colorChangeMs / 1000.0
	timer.start()
	add_child(timer)
	
func tick():
	modulate = random_color()
	
func random_color() -> Color:
	return Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))