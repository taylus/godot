extends Control

func _ready() -> void:
	var level_select_buttons = get_tree().get_nodes_in_group("level_buttons")
	for button in level_select_buttons:
		button.connect("pressed", self, "_on_level_button_pressed", [button])

func _on_level_button_pressed(button: Button) -> void:
	var levelToLoad = "res://scenes/levels/level_%s.tscn" % button.text
	if _file_exists(levelToLoad): get_tree().change_scene(levelToLoad)
	
func _file_exists(pathname: String) -> bool:
	var file = File.new()
	return file.file_exists(pathname)