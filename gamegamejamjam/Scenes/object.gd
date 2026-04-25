extends Area2D

var is_carried := false
var carrier = null

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	if is_carried and carrier:
		global_position = (carrier.global_position + Vector2(0, -20)).round()

		if Input.is_action_just_pressed("drop"):
			drop()

func _on_body_entered(body):
	if body.name == "Player" and not is_carried:
		pick_up(body)

func pick_up(body):
	is_carried = true
	carrier = body

func drop():
	is_carried = false
	carrier = null
