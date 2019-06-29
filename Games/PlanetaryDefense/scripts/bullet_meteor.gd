extends "res://scripts/meteor.gd"

class_name BulletMeteor

# TODO: make these meteors flash a ! on the screen when they spawn
# positioned at the angle they're coming in from, and not start
# moving toward the planet for a few seconds, but once they do,
# they zoom in really fast (hence, bullet meteors)

func _get_fall_speed() -> float:
	return ._get_fall_speed() * 4