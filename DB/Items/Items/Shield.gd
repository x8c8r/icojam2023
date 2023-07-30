class_name Shield extends Item

func use_item(direction:Vector2i, slot:InventorySlot):
	super(direction, slot)
	expendable = true
	
	print("shiel brokey :(")
