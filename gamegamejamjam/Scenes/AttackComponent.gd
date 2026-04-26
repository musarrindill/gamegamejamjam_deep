extends Area2D
class_name AttackComponent

@onready var cooldown: Timer = $Cooldown
@export var damage : int = 34

var hitbox : HitboxComponent

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Hitbox":
		hitbox = area
		cooldown.start(1)
		

func attack() -> void:
	if hitbox:
		hitbox.take_damage(damage)

func _on_cooldown_timeout() -> void:
	attack()
