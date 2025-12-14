extends Area2D

var collected = false

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if collected:
		return
		
	if area.is_in_group("Player"):
		if area.has_method("collect_book"):
			collected = true
			area.collect_book()
			
			# Switch sprites
			$Closed.hide()
			$Opened.show()
			
			# Wait for 2 seconds then disappear
			await get_tree().create_timer(2.0).timeout
			queue_free()
