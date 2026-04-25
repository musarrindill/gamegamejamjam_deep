extends CharacterBody2D
class_name SpawnableCharacter

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var lifetimer: Timer = $Lifetimer

@export var maxHealth = 100
var health : int
@export var lifetime: int = 10
@export var speed : int = 100
var roamRange : int = 10

enum States{IDLE, ROAMING, CHASING}
var state: int

var targets: Array
var myTarget : CharacterBody2D

func _ready() -> void:
	sprite_2d.frame = randi_range(0, 35)
	health = maxHealth
	state = States.ROAMING
	lifetimer.start(lifetime)

func _process(delta: float) -> void:
	health = remap(lifetimer.time_left, 0, lifetime, 0, maxHealth)
	if health <= 0:
		_die()
	
	if targets.is_empty() == false:
		state = States.CHASING
	
	if state in [States.CHASING]:
		_chase()
	
	if state in [States.ROAMING]:
		velocity = Vector2(
			randi_range(-roamRange,roamRange),
			 randi_range(-roamRange,roamRange),
			).normalized() * speed
		
	move_and_slide()

func _chase() -> void:
	if myTarget:
		var direction : Vector2 = myTarget.position - position
		var chaseSpeed : int = speed * 2
		velocity = direction.normalized() * chaseSpeed
	else:
		state = States.ROAMING

func _die() -> void:
	queue_free()

func _on_search_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		targets.append(body)
		myTarget = targets.pick_random()
