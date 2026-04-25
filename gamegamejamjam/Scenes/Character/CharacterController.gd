extends CharacterBody2D

@export var SPEED = 300.0

@onready var audio_stream_player: AudioStreamPlayer = $Footsteps
@onready var sprite_2d: Sprite2D = $Sprite2D
var current_zone := ""

enum States{IDLE, RUNNING}
var state : int = 0

var direction : Vector2

func _physics_process(delta: float) -> void:
	if direction:
		state = States.RUNNING
	else:
		state = States.IDLE
		
	
	if state in [States.RUNNING]:
		_run()
	
	if state in [States.IDLE]:
		_idle()
	
	velocity = lerp(velocity, velocity, 1 * delta)
	
	move_and_slide()

func _run() -> void:
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	
	if audio_stream_player.is_playing() == false:
			audio_stream_player.play(0)

func _dash() -> void:
	print("dash")
	var dashMult: float = 10
	velocity += direction * SPEED * dashMult
	move_and_slide()

func _idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	velocity.y = move_toward(velocity.y, 0, SPEED)

func _unhandled_input(event: InputEvent) -> void:
	direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	
	if event.is_action_pressed("ui_accept"):
		_dash()
	
