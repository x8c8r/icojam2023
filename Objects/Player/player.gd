extends Node2D

func _ready():
	GameManager.turn_ended.connect(func(): print("end"))
	pass # Replace with function body.
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
