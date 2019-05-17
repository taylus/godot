extends Sprite

const pixelsToMove: int = 200
var initialPosition: Vector2

func _ready() -> void:
	initialPosition = position;

func _process(delta) -> void:
	var ticks = OS.get_ticks_msec()
	var movementAmount = cos(ticks / 500.0) * pixelsToMove
	position = initialPosition + Vector2(movementAmount, 0)
	update_facing()
		
func update_facing() -> void:
	# the 1s are for floating point comparison fudge factor
	if position.x <= (initialPosition.x - pixelsToMove + 1):
		flip_h = false
	elif position.x >= (initialPosition.x + pixelsToMove - 1):
		flip_h = true