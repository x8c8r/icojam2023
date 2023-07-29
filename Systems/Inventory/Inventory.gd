extends Node2D

@export var slots:Array[InventorySlot] = []

func get_weapon() -> Item:
	for slot in slots:
		if slot.item is BaseSword:
			return slot.item
	return null

@export var selected_slot:int = 0

func _process(delta):
	if Input.is_action_just_pressed("inventory_scroll"):
		if (selected_slot > len(slots)-1):
			selected_slot = 0
		else:
			selected_slot += 1
		if (selected_slot < 0):
			selected_slot = len(slots)-1
			
	if Input.is_action_just_pressed("inventory_use_item"):
		use_item()
			
func use_item() -> void:
	var item = slots[selected_slot].item
	if item:
		slots[selected_slot].item.use_item(Vector2.ZERO)
		if item.expendable:
			slots[selected_slot].item = null
