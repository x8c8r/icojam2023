extends Sprite2D

var target: Vector2
var moving:= false
var speed := 200.0
signal done

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(target)
	if moving:
		global_position += Vector2.RIGHT.rotated(rotation)*speed*delta
		if GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, global_position).x > 6 or GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, global_position).y > 6 or GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, global_position).y < 1 or GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, global_position).x < 1 or GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, global_position) == GridHelper.get_cell_pos_in_tilemap(GameManager.get_player().tilemap, GameManager.get_player().global_position):
			emit_signal("done")
			moving = false
