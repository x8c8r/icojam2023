class_name Entity extends Node2D

# INITIALIZATION

@export var base_hp:int = 3
var hp:int = base_hp

@onready var tilemap:TileMap = get_tree().current_scene.get_node("Collision")

func _ready():
	GameManager.turn_ended.connect(end_turn)

func _process(delta):
	process_state()
	
func move(target_pos:Vector2i) -> void:
	var pos = GridHelper.get_cell_pos_in_world(tilemap, target_pos)
	position = pos

## STATES
enum entityState {
	MOVE,
	ATTACK
}
var current_state:entityState = entityState.MOVE

func change_state(target_state:entityState) -> void:
	current_state = target_state

func get_current_state() -> entityState:
	return current_state
	
func process_state() -> void: # ACTION THAT THE ENTITY CAN PERFORM BEFORE THE TURN ENDS
	match current_state	:
		entityState.MOVE:
			move_state()
		entityState.ATTACK:
			attack_state()

func move_state() -> void:
	pass

func attack_state() -> void:
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
	pass
	
func reset_state_stuff() -> void:
	pass
	
# END OF TURN
func end_turn() -> void:
	print("END OF A TURN")
	process_end_state()
	reset_state_stuff()
