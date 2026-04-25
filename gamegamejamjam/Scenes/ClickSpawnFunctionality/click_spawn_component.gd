extends Node2D

@export var Spawnable: PackedScene
@export var followerGroup : Node2D

var clickedPosition: Vector2

var numOfFollowers: int

func _input(event: InputEvent) -> void:
	numOfFollowers = followerGroup.get_child_count()
	print(numOfFollowers)
	
	if numOfFollowers >= 5:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clickedPosition = get_global_mouse_position()
			_spawn(clickedPosition)
			#print(clickedPosition)
			

func _spawn(pos: Vector2) -> void:
	var follower: CharacterBody2D = Spawnable.instantiate()
	followerGroup.add_child(follower)
	follower.position = pos
