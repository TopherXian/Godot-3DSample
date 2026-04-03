extends Node3D

@onready var damageRect = $UI/ColorRect
@onready var playerHP = $UI/playerHPBar
@onready var zombie = $NavigationRegion3D/zombie_3
@onready var scoreLabel = $UI/Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerHP.value = GameManager.player_hp
	
func _process(delta: float) -> void:
	scoreLabel.text = "Score:" + str(GameManager.score)

func _on_player_player_hit() -> void:
	damageRect.visible = true
	await get_tree().create_timer(0.2).timeout
	damageRect.visible = false
#	HP Mechanic
	GameManager.player_hp-= 20
	GameManager.player_hp= max(GameManager.player_hp, 0)
	playerHP.value = GameManager.player_hp
#	GAME OVER
	if GameManager.player_hp <= 0:
		print("Game Over")
		get_tree().quit()
