extends CharacterBody2D

@export var SPEED = 300.0

@onready var audio_stream_player: AudioStreamPlayer = $Footsteps
@onready var sprite_2d: Sprite2D = $Sprite2D

var direction : Vector2

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		
		if audio_stream_player.is_playing() == false:
			audio_stream_player.play(0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
