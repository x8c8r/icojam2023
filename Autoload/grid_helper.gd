extends Node

func get_cell_pos_in_tilemap(tilemap:TileMap, position:Vector2) -> Vector2i:
	#print(GameManager.get_player().tilemap == tilemap)
	return GameManager.get_player().tilemap.local_to_map(position)
	
func get_cell_pos_in_world(tilemap:TileMap, position:Vector2) -> Vector2i:
	return tilemap.map_to_local(position)

func is_valid_movement(tilemap:TileMap, target_pos:Vector2, current_pos:Vector2) -> bool:
	var cell_exists:TileData = tilemap.get_cell_tile_data(0, target_pos)
	#print(target_pos)
	if cell_exists: # There is a tile at that place
		return false
	if target_pos.x < 0 or target_pos.x > 6:
		return false
	if target_pos.y < 0 or target_pos.y > 6:
		return false
	else:
		
		if abs(target_pos.x-current_pos.x + target_pos.y-current_pos.y) > 2: # Target pos is too far away
			return false
		else:
			return true

func get_movement_direction(tilemap:TileMap, target_pos:Vector2, current_pos:Vector2) -> Vector2i:
	return target_pos - current_pos
