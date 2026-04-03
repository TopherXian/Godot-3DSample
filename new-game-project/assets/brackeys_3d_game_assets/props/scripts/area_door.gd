extends Area3D

func _ready():
	connect("body_entered", self._on_body_entered)

func _on_body_entered(body):
	if body.name == "player":
		if GameManager.all_coins_collected():
			print("Player Wins")
			
			GameManager.reset_level()
		else:
			print("Collect all coins first!")
