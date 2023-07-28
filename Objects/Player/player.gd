extends Node2D

enum player_state {
	IDLE,
	MOVE,
	ATTACK
}

var current_state:player_state = player_state.IDLE

func change_state(target_state:player_state) -> void:
	current_state = target_state

func get_current_state() -> player_state:
	return current_state
