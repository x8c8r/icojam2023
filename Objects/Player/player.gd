extends Node2D

# INITIALIZATION
var out = preload("res://Objects/outline.tscn")
var outline = out.instantiate()
func _ready():
	GameManager.turn_ended.connect(end_turn)
	get_tree().current_scene.add_child.call_deferred(outline)

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target

const MOVEMENT_SIZE = 64

func get_cell_pos_in_tilemap(position:Vector2) -> Vector2i:
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	return tilemap.local_to_map(position)

func check_movement(position:Vector2i) -> bool:
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	var cell_exists = tilemap.get_cell_tile_data(0, position)
	var player_pos = get_cell_pos_in_tilemap(self.position)
	if cell_exists: # There is a tile at that place
		return false
	else:
		var v2_pos = Vector2(position)
		var v2_pl_pos = Vector2(player_pos)
		if v2_pos.distance_to(v2_pl_pos) > 1:
			return false
		else:
			return true

func move(target_pos:Vector2i) -> void:
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	var pos = tilemap.map_to_local(target_pos)
	position = pos
	
## OUTLINE
func move_outline(target_pos:Vector2) -> void:
	outline.position = get_cell_pos_in_tilemap(target_pos)*64

# LOOP
func check_inputs() -> Dictionary:
	return {
		switch_state = Input.is_action_just_pressed("action_toggle_move_attack"),
		confirm_action = Input.is_action_just_pressed("confirm_action")
	}

func handle_inputs(inputs:Dictionary) -> void:
	if inputs.switch_state:
		state_change()
		
	pass

func _process(delta:float):
	var inputs:Dictionary = check_inputs()
	
	handle_inputs(inputs)
	process_state(inputs)
	move_outline(get_viewport().get_mouse_position())
	
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
	
func process_state(inputs:Dictionary) -> void: # ACTION THAT THE PLAYER CAN PERFORM BEFORE THE TURN ENDS
	match current_state	:
		playerState.MOVE:
			move_state(inputs)
		playerState.ATTACK:
			attack_state(inputs)
			
func attack_state(inputs:Dictionary) -> void:
	pass
	
func move_state(inputs:Dictionary) -> void:
	if inputs.confirm_action:
		var pos = get_cell_pos_in_tilemap(get_viewport().get_mouse_position())
		if check_movement(pos):
			move_tile_target = pos
			
			
		
	pass
	
func process_end_state() -> void: # THE ACTUAL ACTION THAT HAPPENS AT THE END OF THE TURN
	match current_state:
		playerState.MOVE:
			end_move_state()
		playerState.ATTACK:
			end_attack_state()
	pass
	
func end_attack_state() -> void:
	pass
	
func end_move_state() -> void:
	if move_tile_target != prev_move_tile_target:
		move(move_tile_target)
	prev_move_tile_target = move_tile_target
	pass
	
func reset_state_stuff() -> void:
	# MOVEMENT
	current_state = playerState.MOVE
	pass
	
# END OF TURN
func end_turn() -> void:
	print("END OF A TURN")
	process_end_state()
	reset_state_stuff()
	
