extends ProgressBar

var parent: SpawnableCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	max_value = parent.maxHealth
	value = max_value

func _process(delta: float) -> void:
	value = parent.health
