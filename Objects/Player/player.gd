extends Node2D

enum player_state {
	IDLE,
	MOVE,
	ATTACK
}

var current_state:player_state = player_state.IDLE

func _ready():
	move(Vector2(64, 0))

func change_state(target_state:player_state) -> void:
	current_state = target_state

func get_current_state() -> player_state:
	return current_state

func move(increment:Vector2):
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	var pos_grid = tilemap.get_cell_tile_data(0, tilemap.local_to_map(position + increment))
	if pos_grid: 
		print("cant fucking move you dumb shit idiot")
	else:
		print("can move :+1:")
