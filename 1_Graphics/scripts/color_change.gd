extends Sprite

export var colorChangeMs = 300    # change colors every this many milliseconds
var lastChangedTicks: int

func _process(delta) -> void:
	var ticks = OS.get_ticks_msec()
	if (ticks - lastChangedTicks > colorChangeMs):
		lastChangedTicks = ticks
		modulate = random_color()
	
func random_color() -> Color:
	return Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))