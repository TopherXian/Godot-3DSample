extends Node

var total_coins := 0
var collected_coins := 0
var level := 1
var player_hp := 100
var score := 0

func register_coin():
	total_coins += 1

func collect_coin():
	print("collected coin")
	collected_coins += 1
	score += 10
	emit_signal("coin_collected", score)

func all_coins_collected() -> bool:
	return collected_coins >= total_coins
	
	
func reset_level():
	level += 1
	print("Advancing to level:", level)
	
	# reset coin counters
	total_coins = 0
	collected_coins = 0
	
	# reload current scene
	get_tree().reload_current_scene()
