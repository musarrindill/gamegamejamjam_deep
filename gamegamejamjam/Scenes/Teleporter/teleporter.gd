extends Area2D
class_name Teleporter

@export var counterpart: Teleporter
@export var offset: Marker2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer if has_node("AudioStreamPlayer") else null
func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"):
		body.position = counterpart.position + offset.position
		if audio:
			audio.play()
