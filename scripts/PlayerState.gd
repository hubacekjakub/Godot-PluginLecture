extends Node


const MAX_HEALTH = 100

var health = 100
var coins = 0
var books = 0


func increase_health(value: int):
	health = clamp(health + value, 0, MAX_HEALTH)
	# HUD.update_health()

func decrease_health(value: int):
	health = clamp(health - value, 0, MAX_HEALTH)
	# HUD.update_health()
	
func add_coins(value: int):
	coins += value
	# HUD.update_coins()

func add_book():
	books += 1

