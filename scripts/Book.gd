extends Area2D

var collected = false

func _on_area_entered(area: Area2D) -> void:
	print("collected")
	if collected:
		return
		
	if area.is_in_group("Player"):
		if area.has_method("collect_book"):
			collected = true
			area.collect_book()
			
			# Switch sprites
			$Closed.hide()
			$Opened.show()
			
			$CanvasLayer.show()
			await get_tree().create_timer(1.0).timeout
			$CanvasLayer.hide()
			await get_tree().create_timer(1.0).timeout
			queue_free()
