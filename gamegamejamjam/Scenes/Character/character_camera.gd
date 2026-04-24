extends Camera2D

enum States{FOLLOW, ZOOMEDOUT}
var state : int

var defaultZoom : Vector2
var smoothness: float = 8

func _ready() -> void:
	defaultZoom = zoom

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		state = !state
		print(state)
		
func _process(delta: float) -> void:
	if state in [States.FOLLOW]:
		zoom = lerp(zoom, defaultZoom, smoothness * delta)
	elif state in [States.ZOOMEDOUT]:
		var zoomout := Vector2(0.25, 0.25)
		zoom = lerp(zoom, zoomout, smoothness * delta)
