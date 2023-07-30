class_name LittleArcher extends Entity

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

	if tile_player_pos.x != tile_pos.x and tile_player_pos.y != tile_pos.y:
		#print("xy")
		var rand = randf()
		#print(EnemiesManager.enemies_targets)
		
		if abs(tile_pos.x-tile_player_pos.x) <= abs(tile_pos.y-tile_player_pos.y) and not EnemiesManager.enemies_targets.has(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos):
			EnemiesManager.enemies_targets.append(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
			move(Vector2i(clamp(direction.x, -1, 1), 0) + tile_pos)
			#print("->x")

		else: 
			if not EnemiesManager.enemies_targets.has(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos):
				EnemiesManager.enemies_targets.append(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
				move(Vector2i(0, clamp(direction.y, -1, 1)) + tile_pos)
				#print("->y")
		

	else:
		GameManager.get_player().damage(attack_damage)

func compute_stats():
	attack_damage = level + 1
	hp = max(1,level/2)
	#print("enemy hp:", hp)

func die():
	EnemiesManager.enemies = EnemiesManager.enemies.filter(func(val): return val != self)
	if EnemiesManager.enemies.is_empty():
		GameManager.room += 1
		$"../UI/FadeInOut/AnimationPlayer".play_backwards("FadeIn")
		await $"../UI/FadeInOut/AnimationPlayer".animation_finished
		get_tree().reload_current_scene()
	await get_tree().process_frame
	
	super()
