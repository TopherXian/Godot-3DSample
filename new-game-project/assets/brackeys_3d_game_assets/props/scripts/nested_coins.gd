extends Area3D

func _ready():
	connect("body_entered", self._on_body_entered)
	GameManager.register_coin()

func _on_body_entered(body):
	if body.name == "player":
		GameManager.collect_coin()
		queue_free()
