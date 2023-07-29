class_name BaseSword extends Item

func use_item(direction:Vector2i) -> void:
	var player = GameManager.get_player()
	
	var targets:Array[Vector2i] = []
	
	targets.append(GridHelper.get_cell_pos_in_tilemap(player.tilemap, player.position) - direction)
	match direction:
		[Vector2i.DOWN, Vector2i.UP]:
			targets.append(targets[0] + Vector2i(1, 0))
			targets.append(targets[0] + Vector2i(-1, 0))
		[Vector2i.RIGHT, Vector2i.LEFT]:
			targets.append(targets[0] + Vector2i(0, 1))
			targets.append(targets[0] + Vector2i(0, -1))
			
	for target in targets:
		for enemy in EnemiesManager.enemies:
			var en = EnemiesManager.enemies[enemy]
			if GridHelper.get_cell_pos_in_tilemap(player.tilemap, en.position) == target:
				print("found a fucker")
	
	
