extends Node

func _ready():
	print("Running on: ", OS.get_name())
	print("Model: ", OS.get_model_name())
	print("Screen size: ", OS.get_screen_size())
