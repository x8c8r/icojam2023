class_name HealthPotion extends Item

@export var heal_amount:int = 3

func use_item(direction:Vector2i, slot:InventorySlot) -> void:
	
	var player = GameManager.get_player()
	if player:
		player.heal(heal_amount)
		print("kill me :3")
		
	super(direction, slot)
