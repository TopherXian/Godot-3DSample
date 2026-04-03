extends Node3D

@export var zombie_scene: PackedScene
@export var coin_scene: PackedScene

@onready var zombies = $"../Enemies"
@onready var objectives = $"../Objectives"
@onready var player = $"../../player"


@export var min_x := 2.5
@export var max_x := 18.4
@export var min_z := 1.4
@export var max_z := 17.4
@export var spawn_y := 0.6


func get_coin_count():
	match GameManager.level:
		1:
			return 1   # if you're still supporting level 0
		2:
			return 2
		3:
			return 3
		_:
			return 4
		
func get_zombie_count():
	match GameManager.level:
		1:
			return 1   # if you're still supporting level 0
		2:
			return 2
		_:
			return 3
			
func get_random_position() -> Vector3:
	return Vector3(
		randf_range(min_x, max_x),
		spawn_y,
		randf_range(min_z, max_z)
	)

func _ready():
	randomize()
	
	spawn_coins()
	spawn_zombies()
	
func spawn_coins():
	var count = get_coin_count()
	
	for i in count:
		var coin = coin_scene.instantiate()
		coin.global_position = get_random_position()
		objectives.add_child(coin)
		
func spawn_zombies():
	var count = get_zombie_count()
	
	for i in range(count):
		var zombie = zombie_scene.instantiate()
		zombie.global_position = get_random_position()
		
		zombie.player = player
		
		zombies.add_child(zombie)
