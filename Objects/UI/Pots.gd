extends Control

@onready var pots:Array[Node] = self.get_children()

func _process(delta):
	var potss:int = Inventory.get_item_amount(HealthPotion)
	for pot in pots:
		pot.visible = false
	for i in range(potss):
		pots[i].visible = true
