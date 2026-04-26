extends Area2D

@export var zone_name: String = "lungs"


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		body.current_zone = zone_name

func _on_body_exited(body):
	if body.name == "Player" and body.current_zone == zone_name:
		body.current_zone = ""
