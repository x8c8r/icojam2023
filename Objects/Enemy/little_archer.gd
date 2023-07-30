class_name LittleArcher extends Entity

@export var level:int = 1
@export var max_tile_per_turn:int = 1
@export var attack_damage:int = 1
@export var tile_size = 64
@export var arrow_speed = 200.0

# MOVEMENT
var move_tile_target:Vector2
var prev_move_tile_target:Vector2 = move_tile_target
var shoot_axis:Vector2i

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
		if tile_player_pos.x == tile_pos.x or tile_player_pos.y == tile_pos.y:
			if shoot_axis == (GameManager.get_player().position - position).normalized():
				var tween = get_tree().create_tween()
				$Arrow.show()
				$Arrow.position = Vector2.ZERO
				GameManager.get_node("Timer").paused = true
				$Arrow.target = GameManager.get_player().global_position
				tween.tween_property($Arrow, "global_position", GameManager.get_player().global_position, global_position.distance_to(GameManager.get_player().global_position)/arrow_speed)
				await tween.finished
				$Arrow.hide()
				GameManager.get_player().damage(attack_damage)
				GameManager.get_node("Timer").paused = false
				return
			else:
				shoot_axis = (GameManager.get_player().position - position).normalized()
		
		var tween = get_tree().create_tween()
		$Arrow.show()
		$Arrow.position = Vector2.ZERO
		print((tile_pos + shoot_axis*8).clamp(Vector2i.ZERO, Vector2i.ONE*7))
		tween.tween_property($Arrow, "global_position", Vector2i(((Vector2i(tile_pos) + shoot_axis*8).clamp(Vector2i.ZERO, Vector2i.ONE*7)*64))+Vector2i.ONE*32, global_position.distance_to(((Vector2i(tile_pos) + shoot_axis*8).clamp(Vector2i.ZERO, Vector2i.ONE*7)*64)+Vector2i.ONE*32/arrow_speed))
		$Arrow.target = ((tile_pos + shoot_axis*8).clamp(Vector2i.ZERO, Vector2i.ONE*7)*64)+Vector2i.ONE*32
		await tween.finished
		$Arrow.hide()
		$warning.hide()
		return
	


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
		$warning.show()
		shoot_axis = (GameManager.get_player().position - position).normalized()
		


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
