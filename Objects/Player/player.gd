extends Node2D

# INITIALIZATION
func _ready():
	GameManager.turn_ended.connect(end_turn)

# MOVEMENT
var can_move:bool = false

const MOVEMENT_SIZE = 64

func check_movement(increment:Vector2):
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	var pos_grid = tilemap.get_cell_tile_data(0, tilemap.local_to_map(position + increment))
	if pos_grid: # There is a tile at that place
		can_move = false
	else:
		can_move = true

# LOOP
func check_inputs() -> Dictionary:
	return {
		switch_state = Input.is_action_just_pressed("action_toggle_move_attack")
	}

func handle_inputs(inputs:Dictionary) -> void:
	if inputs.switch_state:
		state_change()
		
	pass

func _process(delta:float):
	var inputs:Dictionary = check_inputs()
	
	handle_inputs(inputs)
	process_state()
	
# STATES
enum playerState {
	MOVE,
	ATTACK
}

var current_state:playerState = playerState.MOVE

func change_state(target_state:playerState) -> void:
	current_state = target_state

func get_current_state() -> playerState:
	return current_state
	
func state_change() -> void:
	if current_state == playerState.ATTACK:
		current_state = playerState.MOVE
	else:
		current_state = playerState.ATTACK
	
	print("Changed state to: ", str(current_state))
	
func process_state() -> void: # ACTION THAT THE PLAYER CAN PERFORM BEFORE THE TURN ENDS
	match current_state	:
		playerState.MOVE:
			move_state()
			pass
		playerState.ATTACK:
			attack_state()
			pass
			
func attack_state() -> void:
	pass
	
func move_state() -> void:
	pass
	
func process_state_action() -> void: # THE ACTUAL ACTION THAT HAPPENS AT THE END OF THE TURN
	pass
	
# END OF TURN
func end_turn() -> void:
	print("END OF A TURN")
	process_state_action()
	current_state = playerState.MOVE
