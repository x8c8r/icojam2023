extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Score.add_theme_font_size_override("font_size", 64)
	$CanvasLayer/Score.text = "Score: " + str(GameManager.room)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/base_room.tscn")
