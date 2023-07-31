extends Entity

# INITIALIZATION

var inputs:Dictionary

# MOVEMENT
# get_cell_pos_in_tilemap

var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target
@export var attack_damage = 5

## OUTLINE
@onready var outlines:Array[Node] = $Outlines.get_children()
var cur_outline:Outline
var last_outline:Outline
	
func colour_outline() -> void:
	match get_current_state():
		entityState.MOVE:
			for n in len(outlines):
				var out:Outline = outlines[n]
				out.set_color(Color.GREEN)
		entityState.ATTACK:
			for n in len(outlines):
				var out:Outline = outlines[n]
				out.set_color(Color.YELLOW)		

func move_outline(target_pos:Vector2) -> void:
	for outline in outlines:
		outline.update(target_pos, position, current_state)

func get_outline(dir:Vector2i) -> Outline:
	for i in outlines:
		if i.direction == -dir:
			return i
	return
func reset_outline() -> void:
	if cur_outline:
		cur_outline.selected = false
	cur_outline = null
	last_outline = null
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
	#print(tilemap)
	inputs = check_inputs()
	handle_inputs(inputs)
	
	super(delta)
	
	colour_outline()
	move_outline(get_viewport().get_mouse_position())
	
# STATES
func change_state(target_state:entityState) -> void:
	current_state = target_state
	reset_outline()

func get_current_state() -> entityState:
	return current_state
	
func state_change() -> void:
	if current_state == entityState.ATTACK:
		change_state(entityState.MOVE)
	else:
		change_state(entityState.ATTACK)
	
			
func attack_state() -> void:
	super()
	if inputs.confirm_action:
		var pos = GridHelper.get_cell_pos_in_tilemap(tilemap, get_viewport().get_mouse_position())
		#print(Inventory.get_weapon())
		if Inventory.get_weapon():
			var wep = Inventory.get_item_by_type(BaseSword)
			var dir = GridHelper.get_cell_pos_in_tilemap(tilemap, position)-pos
			if wep[0]:
				wep[0].use_item(dir, wep[1])
			cur_outline = get_outline(dir)
			if cur_outline:
				cur_outline.selected = true
				if cur_outline != last_outline && last_outline:
					last_outline.selected = false
				last_outline = cur_outline
	pass
	
func move_state() -> void:
	super()
	if inputs.confirm_action:
		print(tilemap)
		var pos = GridHelper.get_cell_pos_in_tilemap(tilemap, get_viewport().get_mouse_position())
		
		if GridHelper.is_valid_movement(tilemap,GridHelper.get_cell_pos_in_tilemap(tilemap, position),pos):
			cur_outline = get_outline(GridHelper.get_movement_direction(tilemap, GridHelper.get_cell_pos_in_tilemap(tilemap, position), pos))
			if cur_outline:
				cur_outline.selected = true
				if cur_outline != last_outline && last_outline:
					last_outline.selected = false
				last_outline = cur_outline
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
	#print(get_outline(-(Vector2i(move_tile_target)-GridHelper.get_cell_pos_in_tilemap(tilemap, position))).visible)
	if move_tile_target != prev_move_tile_target and get_outline(-(Vector2i(move_tile_target)-GridHelper.get_cell_pos_in_tilemap(tilemap, position))).visible:
		move(move_tile_target)
	prev_move_tile_target = move_tile_target
	pass
	
func reset_state_stuff() -> void:
	reset_outline()
	current_state = entityState.MOVE
	
func damage(amount:int):
	var shield = Inventory.get_item_by_type(Shield)
	if shield[0]:
		shield[0].use_item(Vector2i.UP, shield[1])
		return
	hp -= amount
	if hp <= 0:
		die()
	#print(hp)

func die():
	print(GameManager.room)
	get_tree().change_scene_to_file("res://Scenes/you_died.tscn")
	super()

func _ready():
	super()
	hp = GameManager.health
	$"../../UI/Score".text = "Room: " + str(GameManager.room)
	print(hp)
