extends CharacterBody3D

var player = null
var speed = 2.0
const attackRange = 1.5

signal zombie_hit

@export var max_hp: int = 30
var current_hp
var stateMachine 

#FOR ASSIGNING THE PLAYER
@export var playerPath: CharacterBody3D

#ASSIGN THE NAVIGATION AGENT
@onready var navAgent = $NavigationAgent3D
@onready var animTree = $AnimationTree
@onready var hitbox = $"Mesh/Skeleton3D/PhysicalBoneSimulator3D/Physical Bone mixamorig_RightHand/rightHand"
@onready var zombieHP = $SubViewport/zombieHPBar


func _ready() -> void:
	var multiplier = 1.0 + (GameManager.level * 0.1-0.1)
	speed = speed * multiplier
	max_hp = int(max_hp * multiplier)
	current_hp = max_hp
	
	stateMachine = animTree.get("parameters/playback")
	print("Zombie Stats → Speed:", speed, " HP:", max_hp)
	
func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	zombieHP.value = current_hp

	
#	MODEL DIRECTION

	animTree.set("parameters/conditions/attack", checkRange())
	animTree.set("parameters/conditions/run", !checkRange())
	
	match stateMachine.get_current_node():
		"run":
			#	NAVIGATION
			navAgent.set_target_position(player.global_transform.origin)
			var next_navPoint = navAgent.get_next_path_position()
			velocity = (next_navPoint - global_transform.origin).normalized()*speed
			look_at(Vector3(player.global_position.x + velocity.x, player.global_position.y, player.global_position.z + velocity.z), Vector3.UP) 
		"attack":
			look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP) 
	move_and_slide()
	
func checkRange():
	return global_position.distance_to(player.global_position) < attackRange
	
	
func attackHit():
	var bodies = hitbox.get_overlapping_bodies()
	
	if player in bodies:
		player.hit()
		print("player damaged")
	else:
		print("miss")

func take_damage(amount: int):
	current_hp -= amount
	current_hp = max(current_hp, 0)
	if current_hp == 0:
		die()
		
func die():
	queue_free()  # or play death animation
