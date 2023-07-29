class_name BaseSword extends Item
var targets:Array[Vector2i] = []
var player

func use_item(direction:Vector2i) -> void:
	targets = []
	if !GameManager.turn_ended.is_connected(attack_enemy):
		GameManager.turn_ended.connect(attack_enemy)
	player = GameManager.get_player()
	
	targets.append(GridHelper.get_cell_pos_in_tilemap(player.tilemap, player.position) - direction)
	match direction:
		[Vector2i.DOWN, Vector2i.UP]:
			targets.append(targets[0] + Vector2i(1, 0))
			targets.append(targets[0] + Vector2i(-1, 0))
			print("a")
		[Vector2i.RIGHT, Vector2i.LEFT]:
			targets.append(targets[0] + Vector2i(0, 1))
			targets.append(targets[0] + Vector2i(0, -1))
			print("b")
	
		#print(GameManager.get_player().get_current_state())
			
func attack_enemy() -> void:
	#print("attack")
	GameManager.turn_ended.disconnect(attack_enemy)
	#print(targets.size())
	#print(targets[0]-GridHelper.get_cell_pos_in_tilemap(player.tilemap, player.position))
	for target in targets:
		for enemy in EnemiesManager.enemies:
			#print(len(EnemiesManager.enemies))
			print("umm")
			if GridHelper.get_cell_pos_in_tilemap(player.tilemap, enemy.position) == target:
#				print("found a fucker")
#				print(en)
				
				enemy.take_damage(GameManager.get_player().attack_damage)
				#GameManager.emit_signal("turn_ended")
				GameManager.get_player().change_state(GameManager.get_player().entityState.MOVE)
	
