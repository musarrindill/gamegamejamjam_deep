extends Node2D

var _fullscreen : bool

var playerIsDead : bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_escapeToMainMenu()
	
	if event.is_action_pressed("Fullscreen"):
		_fullscreen = !_fullscreen
		
		if _fullscreen == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("Restart"):
		_restartScene()


func _on_player_character_died() -> void:
	if playerIsDead == false:
		var resetTimer := Timer.new()
		add_child(resetTimer)
		resetTimer.start(3)
		resetTimer.timeout.connect(_escapeToMainMenu)
		print("died")
	playerIsDead = true
	
func _on_player_player_won() -> void:
	var resetTimer := Timer.new()
	add_child(resetTimer)
	resetTimer.start(3)
	resetTimer.timeout.connect(_escapeToMainMenu)
	print("won")

func _restartScene() -> void:
	get_tree().reload_current_scene()

func _escapeToMainMenu() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
