extends Area2D
class_name HitboxComponent

func take_damage(damage: int) -> void:
	var parent = get_parent()
	if parent.health:
		parent.health -= damage
