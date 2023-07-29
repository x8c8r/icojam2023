class_name game_manager extends Node

var floor:int = 1

## Emitted when the time for the turn runs out
signal turn_ended

func _process(delta):
	get_tree().current_scene.get_node("UI").get_node("UITimer").change_time($Timer.time_left)
	
func turn_end() -> void:
	turn_ended.emit()
	pass

func _on_timer_timeout():
	turn_end()
	pass

func _ready():
	randomize()

func get_player():
	return get_tree().get_first_node_in_group("Player")

func get_collision():
	return get_tree().get_first_node_in_group("CollisionTilemap")
