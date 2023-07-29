class_name Item extends Resource

@export_group("Info")
## Title of the item
@export var title:String = ""
## Description of the item
@export_multiline var description:String = ""

@export_group("Stats")
## Max amount of item in the inventory
@export var max_amount:int = 1 

func use_item(direction:Vector2i) -> void:
	pass
