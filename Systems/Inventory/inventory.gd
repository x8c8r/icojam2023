extends Node2D

@export var slots:Array[InventorySlot] = []

func get_weapon() -> Item:
	for slot in slots:
		print(slot.item)
		if slot.item is BaseSword:
			return slot.item
	return null
	
func get_item_by_type(type:Variant) -> Array:
	for slot in slots:
		if slot.item != null:
			if slot.item.get_script() == type:
				return [slot.item, slot]
	return [null, null]

@export var selected_slot:int = 0
func _ready():
	add_item(BaseSword.new(), false)
	add_item(HealthPotion.new(), true)
	add_item(Shield.new(), true)

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
			
func add_item(item:Item, expendable:bool):
	item.expendable = expendable
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
			
func use_item() -> void:
	var item = slots[selected_slot].item
	print("sex")
	if item:
		item.use_item(Vector2.ZERO, slots[selected_slot])
