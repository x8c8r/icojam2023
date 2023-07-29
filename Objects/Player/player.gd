extends Entity

# INITIALIZATION

var inputs:Dictionary

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target

## OUTLINE
@onready var outlines:Array = [$Icon, $Icon2, $Icon3, $Icon4]
func color_outline() -> void:
	match get_current_state():
		entityState.MOVE:
			for n in len(outlines):
				var out:Sprite2D = outlines[n]
				out.modulate = Color.GREEN
		entityState.ATTACK:
			for n in len(outlines):
				var out:Sprite2D = outlines[n]
				out.modulate = Color.YELLOW				

func move_outline(target_pos:Vector2) -> void:
	pass
	$Icon.visible = GridHelper.is_valid_movement($"../Collision", GridHelper.get_cell_pos_in_tilemap($"../Collision", position)+Vector2i.RIGHT, GridHelper.get_cell_pos_in_tilemap($"../Collision", position))
	$Icon2.visible = GridHelper.is_valid_movement($"../Collision", GridHelper.get_cell_pos_in_tilemap($"../Collision", position)+Vector2i.LEFT, GridHelper.get_cell_pos_in_tilemap($"../Collision", position))
	$Icon3.visible = GridHelper.is_valid_movement($"../Collision", GridHelper.get_cell_pos_in_tilemap($"../Collision", position)+Vector2i.DOWN, GridHelper.get_cell_pos_in_tilemap($"../Collision", position))
	$Icon4.visible = GridHelper.is_valid_movement($"../Collision", GridHelper.get_cell_pos_in_tilemap($"../Collision", position)+Vector2i.UP, GridHelper.get_cell_pos_in_tilemap($"../Collision", position))

# LOOP
func check_inputs() -> Dictionary:
	return {
		switch_state = Input.is_action_just_pressed("action_toggle_move_attack"),
		confirm_action = Input.is_action_just_pressed("confirm_action")
	}

func handle_inputs(inputs:Dictionary) -> void:
	if inputs.switch_state:
		state_change()

func _process(delta:float):
	inputs = check_inputs()
	handle_inputs(inputs)
	
	
	
	super(delta)
	
	color_outline()
	move_outline(get_viewport().get_mouse_position())
	
# STATES

func change_state(target_state:entityState) -> void:
	current_state = target_state

func get_current_state() -> entityState:
	return current_state
	
func state_change() -> void:
	if current_state == entityState.ATTACK:
		current_state = entityState.MOVE
	else:
		current_state = entityState.ATTACK
	
			
func attack_state() -> void:
	super()
	if inputs.confirm_action:
		var pos = GridHelper.get_cell_pos_in_tilemap(tilemap, get_viewport().get_mouse_position())
		print(Inventory.get_weapon())
		if Inventory.get_weapon():
			var wep = Inventory.get_weapon()
			var dir = GridHelper.get_cell_pos_in_tilemap(tilemap, position)-pos
			wep.use_item(dir)
	
	pass
	
func move_state() -> void:
	super()
	if inputs.confirm_action:
		var pos = GridHelper.get_cell_pos_in_tilemap(tilemap, get_viewport().get_mouse_position())
		
		if GridHelper.is_valid_movement(tilemap,GridHelper.get_cell_pos_in_tilemap(tilemap, position),pos):
			move_tile_target = pos		
	pass
	
func process_end_state() -> void: # THE ACTUAL ACTION THAT HAPPENS AT THE END OF THE TURN
	match current_state:
		entityState.MOVE:
			end_move_state()
		entityState.ATTACK:
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
	pass

func damage(amount):
	hp -= amount
	if hp <= 0:
		get_tree().reload_current_scene()
	print("wow motherfucker you did " + str(amount) + " hp! I have " +str(hp))
