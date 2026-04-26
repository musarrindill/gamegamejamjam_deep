extends AudioStreamPlayer

func _ready() -> void:
	SignalBus.EnemyDied.connect(_playDeathSound)
	
func _playDeathSound():
	print("play sound")
	play(0)
