extends Area2D

@export var value: int = 1

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area.is_in_group("Player"):
		if area.has_method("collect_coins"):
			area.collect_coins(value)
			queue_free()
