extends Node2D

@export var Spawnable: PackedScene
@export var followerGroup: Node2D
@export var speech_bubble: Panel

var clickedPosition: Vector2

var numOfFollowers: int
var maxFollowers: int = 5
var availableFollowers: int

func _process(_delta: float) -> void:
	numOfFollowers = followerGroup.get_child_count()
	availableFollowers = maxFollowers - numOfFollowers

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if numOfFollowers >= maxFollowers:
				speech_bubble.say_one("no_spawns_left", 3.0)
				return

			clickedPosition = get_global_mouse_position()
			_spawn(clickedPosition)

func _spawn(pos: Vector2) -> void:
	var follower: CharacterBody2D = Spawnable.instantiate()
	followerGroup.add_child(follower)
	follower.position = pos
