extends Node

var enemies:Array = []
var enemies_targets:Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_enemies_pos() -> Dictionary:
	var result := {}
	for i in get_tree().current_scene.get_node("Enemies").get_children():
		result[i] = GridHelper.get_cell_pos_in_tilemap(i.tilemap, i.position)
		
	
	return result
