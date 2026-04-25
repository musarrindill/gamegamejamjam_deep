extends Node2D
class_name Spawnpoint

@export var enemyToSpawn : PackedScene
@onready var spawn_timer: Timer = $SpawnTimer
@onready var enemies_spawned: Node2D = $EnemiesSpawned

func _on_spawn_timer_timeout() -> void:
	var newEnemy = enemyToSpawn.instantiate()
	enemies_spawned.add_child(newEnemy)
	newEnemy.position = position
