class_name BaseEnemy extends Entity

@export var level:int = 1
@export var max_tile_per_turn:int = 1
@export var damage:int = 1

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target
	
func end_move_state() -> void:
	var tilesized_pos:Vector2i = GridHelper.get_cell_pos_in_tilemap(tilemap, position)
	var rand_move:Vector2 = Vector2(tilesized_pos.x + randi_range(-1, 1), tilesized_pos.y + randi_range(-1, 1))
	if GridHelper.is_valid_movement(tilemap, rand_move, GridHelper.get_cell_pos_in_tilemap(tilemap, position)):
		move_tile_target = rand_move
		
	if move_tile_target != prev_move_tile_target:
		move(move_tile_target)
	prev_move_tile_target = move_tile_target
