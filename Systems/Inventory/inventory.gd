class_name Inventory extends Node2D

@export var slots:Array

var slot_amount:int = 3

func _init():
	for n in slot_amount:
		slots.append(InventorySlot.new(n))
		pass
	pass
	
func get_slot(index:int) -> InventorySlot:
	return slots[index]
	
func set_slot_item(index:int, item:Item) -> void:
	var slot:InventorySlot = get_slot(index)
	slot.set_item(item)

func get_slot_item(index:int) -> Item:
	return get_slot(index).get_item()
