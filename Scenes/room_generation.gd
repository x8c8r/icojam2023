extends Node2D

var enemies_pos = []
@export var room_number: int
@export var enemy_path = preload("res://Objects/Enemy/BaseEnemy.tscn")
@export var range_enemy_path = preload("res://Objects/Enemy/little_archer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	room_number = GameManager.room
	print(room_number)
	randomize()
	var number: int
	var level: int
	
	# Calculate number of enemies
	if room_number < 4:
		number = 1
	elif room_number < 11:
		number = randi_range(2, 3)
	else:
		number = 3 + min(room_number, 15)/10
	
	#Calculate enemies' level
	
	level = max(1, room_number-1/1.1)
	
	
	
	spawn_enemies(number, level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_enemies(number, level):
	#print(number, " ", level)
	for i in range(number):
		var enemy_pos = try_enemy_pos()
		spawn_enemy(enemy_pos, level)

func try_enemy_pos():
	var enemy_pos = Vector2i(randi_range(1,6), randi_range(1,6))
	var tilemap:TileMap = get_tree().current_scene.get_node("Collision")
	print(tilemap, get_tree().current_scene)
	var player_pos = GridHelper.get_cell_pos_in_tilemap(tilemap, GameManager.get_player().position)
	if (enemy_pos-player_pos).length() < 3:
		return try_enemy_pos()
	for i in enemies_pos:
		if (enemy_pos-i).length() < 2:
			return try_enemy_pos()
	return enemy_pos

func spawn_enemy(pos, level):
	var e 
	if randi_range(0,1):
		e = enemy_path.instantiate()
	else:
		e = range_enemy_path.instantiate()
	e.position = GridHelper.get_cell_pos_in_world(GameManager.get_player().tilemap, pos)
	e.level = level
	$Enemies.add_child(e)
