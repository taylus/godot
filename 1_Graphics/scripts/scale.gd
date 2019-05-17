extends Sprite

var initialScale: Vector2

func _ready() -> void:
	initialScale = scale;

func _process(delta) -> void:
	var ticks = OS.get_ticks_msec()
	scale = initialScale * 2 * sin(ticks / 500.0)