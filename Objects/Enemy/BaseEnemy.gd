class_name BaseEnemy extends Entity

@export var level:int = 1
@export var max_tile_per_turn:int = 1
@export var damage:int = 1
@export var tile_size = 64

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target

func process_end_state():
	var collision = GameManager.get_collision()
	var player = GameManager.get_player()
	var tile_player_pos: Vector2i = GridHelper.get_cell_pos_in_tilemap(collision, player.position)
	var tile_pos = GridHelper.get_cell_pos_in_tilemap(collision, position)
	var direction = tile_player_pos - tile_pos

	print(direction.length())
	if direction.length() < 1.2:
		move(tile_player_pos)
	elif tile_player_pos.x != tile_pos.x and tile_player_pos.y != tile_pos.y:
		print("xy")
		var rand = randf()
		print(EnemiesManager.enemies_targets)
		if rand > .5 and not Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos in EnemiesManager.enemies_targets.values():
			EnemiesManager.enemies_targets[self] = Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos
			move(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
			print("->x")

		if rand <= .5 and not Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos in EnemiesManager.enemies_targets.values():
			EnemiesManager.enemies_targets[self] = Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos
			move(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
			print("->y")

	elif tile_player_pos.x != tile_pos.x and not Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos in EnemiesManager.enemies_targets.values():
		EnemiesManager.enemies_targets[self] = Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos
		print("x")
		move(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
	elif tile_player_pos.y != tile_pos.y and not Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos in EnemiesManager.enemies_targets.values():
		EnemiesManager.enemies_targets[self] = Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos
		print("y")
		move(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
