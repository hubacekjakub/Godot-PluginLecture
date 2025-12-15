@tool
extends Area2D

var _debug_open: bool = false
@export var debug_open: bool = false:
	get:
		return _debug_open
	set(value):
		_debug_open = value
		if Engine.is_editor_hint():
			$Closed.visible = !_debug_open
			$Opened.visible = _debug_open

var collected = false


func _on_area_entered(area: Area2D) -> void:
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
