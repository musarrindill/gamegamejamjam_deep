extends Area2D

@export var damage : int = 10

var playerCharacter : CharacterBody2D
var inArea : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inArea = true
		playerCharacter = body

func _on_cooldown_timeout() -> void:
	_attackPlayer()

func _attackPlayer() -> void:
	if playerCharacter != null and inArea:
		playerCharacter.health -= damage

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inArea = false
		playerCharacter = null
