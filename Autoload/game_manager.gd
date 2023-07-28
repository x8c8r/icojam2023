class_name game_manager extends Node

## Emitted when the time for the turn runs out
signal turn_ended
	
func turn_end() -> void:
	turn_ended.emit()
	pass

func _on_timer_timeout():
	turn_end()
	pass
	
func get_grid() -> Grid:
	return get_tree().current_scene.get_node("Grid")
