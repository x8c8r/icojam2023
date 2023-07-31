extends Control

@onready var healths:Array[Node] = self.get_children()

func _process(delta):
	var health:int = GameManager.get_player().hp
	for hell in healths:
		hell.visible = false
	for i in range(health):
		healths[i].visible = true
