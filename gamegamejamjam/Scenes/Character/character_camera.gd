extends Camera2D

enum States{FOLLOW, ZOOMEDOUT}
var state : int

var defaultZoom : Vector2
var smoothness: float = 8

var shaking : bool
var shakeFactor : int
var maxShakeFactor : int = 10

func _ready() -> void:
	defaultZoom = zoom

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Zoom"):
		state = !state
		print(state)
		
func _process(delta: float) -> void:
	if state in [States.FOLLOW]:
		zoom = lerp(zoom, defaultZoom, smoothness * delta)
	elif state in [States.ZOOMEDOUT]:
		var zoomout := Vector2(0.25, 0.25)
		zoom = lerp(zoom, zoomout, smoothness * delta)
	
	offset = Vector2(randi_range(-shakeFactor, shakeFactor), randi_range(-shakeFactor, shakeFactor))
	shakeFactor = lerp(shakeFactor, 0, 4 * delta)
	
func _on_player_took_damage() -> void:
	shakeFactor = maxShakeFactor
