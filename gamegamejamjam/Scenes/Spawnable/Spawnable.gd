extends CharacterBody2D
class_name SpawnableCharacter

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var lifetimer: Timer = $Lifetimer

@export var maxHealth = 100
var health : int
@export var lifetime: int = 10
@export var speed : int = 500
var roamRange : int = 5

enum States{IDLE, ROAMING}
var state: int

func _ready() -> void:
	sprite_2d.frame = randi_range(0, 35)
	health = maxHealth
	state = States.ROAMING
	lifetimer.start(lifetime)

func _process(delta: float) -> void:
	health = remap(lifetimer.time_left, 0, lifetime, 0, maxHealth)
	if health <= 0:
		_die()
	
	if state in [States.ROAMING]:
		velocity += Vector2(
			randi_range(-roamRange,roamRange),
			 randi_range(-10,10),
			).normalized() * speed
		
	move_and_slide()

func _die() -> void:
	queue_free()
