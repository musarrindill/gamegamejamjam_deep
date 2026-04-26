extends Control

var _fullscreen : bool = false

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_control_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/controls_information.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	_fullscreen = !_fullscreen
		
	if _fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
