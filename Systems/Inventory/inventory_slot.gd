class_name InventorySlot extends Node

## Item currently occupying the slot
@export var item:Item = null
## Is the slot occupied?
@export var occupied:bool = false
## Slot index
var index:int = 0

func _init(index:int):
	self.index = index
