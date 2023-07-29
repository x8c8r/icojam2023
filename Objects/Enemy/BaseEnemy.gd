class_name BaseEnemy extends Entity

@export var level:int = 1
@export var max_tile_per_turn:int = 1
@export var attack_damage:int = 1
@export var tile_size = 64

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target

func _ready():
	super()
	compute_stats()
	if !EnemiesManager.enemies.has(self):
		EnemiesManager.enemies.append(self)

func process_end_state():
	super()
	
	var enemy_target:int = EnemiesManager.enemies_targets.find(self)
	
	var collision = GameManager.get_collision()
	var player = GameManager.get_player()
	var tile_player_pos: Vector2i = GridHelper.get_cell_pos_in_tilemap(collision, player.position)
	var tile_pos = GridHelper.get_cell_pos_in_tilemap(collision, position)
	var direction = tile_player_pos - tile_pos
	if $warning.visible:
		#print("warning")
		if direction.length() < 1.2:
			await get_tree().create_timer(.1).timeout
			#print("The enemy at " + str(position-player.position) + " Of you is attacking")
			player.damage(attack_damage)
			return
		else:
			$warning.hide()
			return
	if direction.length() < 1.2:
		$warning.show()
		return
	elif tile_player_pos.x != tile_pos.x and tile_player_pos.y != tile_pos.y:
		#print("xy")
		var rand = randf()
		#print(EnemiesManager.enemies_targets)
		
		if rand > .5 and not EnemiesManager.enemies_targets.has(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos):
			EnemiesManager.enemies_targets.append(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
			move(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
			#print("->x")

		if rand <= .5 and not EnemiesManager.enemies_targets.has(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos):
			EnemiesManager.enemies_targets.append(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
			move(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
			#print("->y")
		

	elif tile_player_pos.x != tile_pos.x and not EnemiesManager.enemies_targets.has(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos):
		
		EnemiesManager.enemies_targets.append(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
		#print("x")
		move(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
	elif tile_player_pos.y != tile_pos.y and not EnemiesManager.enemies_targets.has(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos):
		
		EnemiesManager.enemies_targets.append(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
		#print("y")
		move(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)

	else:
		$warning.hide()

func compute_stats():
	attack_damage = level + 1
	hp = level

func die():
	$warning.hide()
	EnemiesManager.enemies = EnemiesManager.enemies.filter(func(val): return val != self)
	await get_tree().process_frame
	
	super()
