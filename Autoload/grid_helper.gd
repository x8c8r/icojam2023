extends Node

func get_cell_pos_in_tilemap(tilemap:TileMap, position:Vector2) -> Vector2i:
	return tilemap.local_to_map(position)
	
func get_cell_pos_in_world(tilemap:TileMap, position:Vector2) -> Vector2i:
	return tilemap.map_to_local(position)

func is_valid_movement(tilemap:TileMap, target_pos:Vector2, current_pos:Vector2) -> bool:
	var cell_exists:TileData = tilemap.get_cell_tile_data(0, target_pos)
	if cell_exists: # There is a tile at that place
		return false
	else:
		if current_pos.distance_to(target_pos) > 1: # Target pos is too far away
			return false
		else:
			return true
