extends Node3D

@onready var switch_state_baby: Timer = $"../SwitchStateBaby"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum States{IDLE, SPIN, SQUASH}

var state : int :
	set(value):
		state = value
		changeAnimation()
	get:
		return state

func changeAnimation() -> void:
	if state in [States.IDLE]:
		animation_player.play("Action")
	elif state in [States.SPIN]:
		animation_player.play("Action_001")
	elif state in [States.SQUASH]:
		animation_player.play("Action_002")

func _on_switch_state_baby_timeout() -> void:
	state = randi_range(0, 2)
