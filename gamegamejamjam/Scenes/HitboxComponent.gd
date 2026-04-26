extends Area2D
class_name HitboxComponent

signal TookDamage

func take_damage(damage: int) -> void:
	var parent = get_parent()
	if parent.health:
		parent.health -= damage
	TookDamage.emit()
