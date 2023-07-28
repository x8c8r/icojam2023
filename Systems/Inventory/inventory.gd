class_name Inventory extends Node2D

@export var slots:Array

var slot_amount:int = 3


func _init():
	for n in slot_amount:
		slots.append(InventorySlot.new(n))
		pass
	pass
