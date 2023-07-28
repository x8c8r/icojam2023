extends Node2D

enum player_state {
	IDLE,
	MOVE,
	ATTACK
}

var can_move:bool = false

const MOVEMENT_SIZE = 64

var current_state:player_state = player_state.IDLE

func change_state(target_state:player_state) -> void:
	current_state = target_state

func get_current_state() -> player_state:
	return current_state

func check_movement(increment:Vector2):
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	var pos_grid = tilemap.get_cell_tile_data(0, tilemap.local_to_map(position + increment))
	if pos_grid: # There is a tile at that place
		can_move = false
	else:
		can_move = true
	
	

func _process
