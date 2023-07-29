class_name BaseEnemy extends Entity

@export var level:int = 1
@export var max_tile_per_turn:int = 1
@export var damage:int = 1

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target
