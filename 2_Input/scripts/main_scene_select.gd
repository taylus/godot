extends Control

func _on_KeyboardAndMouseInputSceneButton_pressed():
	get_tree().change_scene("res://scenes/keyboard_and_mouse.tscn")

func _on_GamepadInputSceneButton_pressed():
	get_tree().change_scene("res://scenes/gamepad.tscn")

func _on_TouchInputSceneButton_pressed():
	get_tree().change_scene("res://scenes/touch.tscn")

func _on_GyroAndAccelerometerInputSceneButton_pressed():
	get_tree().change_scene("res://scenes/gyro_and_accelerometer.tscn")
