extends CharacterBody2D

@export var SPEED = 150
@onready var sprite_2d: Sprite2D = $Sprite2D

var maxHealth : int = 100
var health : int

var player: CharacterBody2D

enum States{IDLE, CHASING}
var state: int

var animFrame : int 

func _ready() -> void:
	state = States.IDLE
	health = maxHealth

func _physics_process(delta: float) -> void:
	if player == null:
		state = States.IDLE
	
	if health <= 0:
		_die()
	
	if state in [States.CHASING]:
		_chase()
	elif state in [States.IDLE]:
		_idle()
		
	move_and_slide()

func _chase() -> void:
	var direction : Vector2
	
	direction = player.position - position
	
	if direction:
		velocity = direction.normalized() * SPEED
		sprite_2d.frame = animFrame % 5
	

func _idle() -> void:
	velocity = Vector2.ZERO

func _die() -> void:
	queue_free()

func _on_search_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		state = States.CHASING

func _on_search_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null


func _on_sprite_timer_timeout() -> void:
	animFrame += 1
