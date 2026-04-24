extends Sprite2D

@onready var timer: Timer = $Timer
var can_flip_sprite : bool = false

@onready var character_body_2d: CharacterBody2D = $".."

func _process(delta: float) -> void:
	if character_body_2d.velocity.normalized() == Vector2(0, 1):
		frame = 0
		can_flip_sprite = true
	elif character_body_2d.velocity.normalized() == Vector2(0, -1):
		frame = 2
		can_flip_sprite = true
	elif character_body_2d.velocity.normalized() == Vector2(1, 0):
		frame = 1
		can_flip_sprite = false
		flip_h = false
	elif character_body_2d.velocity.normalized() == Vector2(-1, 0):
		frame = 1
		can_flip_sprite = false
		flip_h = true
	
	if character_body_2d.velocity.normalized() == Vector2.ZERO:
		timer.stop()
		
	if can_flip_sprite and timer.is_stopped():
		timer.start()
	elif not can_flip_sprite:
		timer.stop()


func _on_timer_timeout() -> void:
	if flip_h == flip_h:
		flip_h = !flip_h
