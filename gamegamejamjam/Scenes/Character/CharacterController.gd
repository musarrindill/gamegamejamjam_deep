extends CharacterBody2D

@export var SPEED = 300.0
@onready var audio_stream_player: AudioStreamPlayer = $Footsteps
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var speech_bubble: Panel
@onready var damage_sounds: AudioStreamPlayer = $DamageSounds

signal CharacterDied
signal TookDamage

var current_zone := ""
var carried_items: Array = []
enum States{IDLE, RUNNING, SPRINTING}
var state : int = 0
var direction : Vector2
var sprint_timer := 0
var is_sprinting := false
var can_sprint := true

var alive : bool = true
@export var maxHealth : int = 250
var health : int :
	set(value):
		health = value
		print("health changed: ", health)
		
		if value != maxHealth and alive:
			damage_sounds.play(0)
			TookDamage.emit()
		if value <= 0:
			_die()
	get:
		return health

func _ready() -> void:
	health = maxHealth

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()

	if sprint_timer > 0:
		sprint_timer -= 1 * delta
	else:
		is_sprinting = false

	if direction:
		state = States.SPRINTING if is_sprinting else States.RUNNING
	else:
		state = States.IDLE

	match state:
		States.RUNNING:
			_run(1.0)
		States.SPRINTING:
			_run(2.0)
		States.IDLE:
			_idle()
	
	if alive:
		move_and_slide()

func _run(speed_mult: float) -> void:
	velocity.x = direction.x * SPEED * speed_mult
	velocity.y = direction.y * SPEED * speed_mult
	audio_stream_player.pitch_scale = speed_mult
	if not audio_stream_player.is_playing():
		audio_stream_player.play(0)

func _idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	velocity.y = move_toward(velocity.y, 0, SPEED)
	audio_stream_player.pitch_scale = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and can_sprint and direction:
		is_sprinting = true
		can_sprint = false
		sprint_timer = 30

	if event.is_action_released("ui_accept"):
		can_sprint = true

func _die():
	alive = false
	visible = false
	CharacterDied.emit()
		
func _process(_delta):
	if Input.is_action_just_pressed("drop"):
		handle_drop()

func handle_drop():
	if carried_items.is_empty():
		return

	var correct_items := []

	for item in carried_items:
		if item.target_zone_name == current_zone:
			correct_items.append(item)

	if correct_items.size() > 0:
		for item in correct_items:
			item.drop()
			carried_items.erase(item)
	else:
		speech_bubble.say_one("wrong_body_part", 3.0)
