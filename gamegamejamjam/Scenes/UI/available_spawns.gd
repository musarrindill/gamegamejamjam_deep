extends ProgressBar

@export var spawnComponent : Node2D

func _process(delta: float) -> void:
	value = spawnComponent.availableFollowers
