class_name Grid extends Node2D

@export var grid_size:Vector2 = Vector2(5, 5)
@export var grid_cell_size:Vector2 = Vector2(64, 64)

const GRID_CELL = preload("res://Systems/Grid/GridCell.tscn")

func _ready():
	generate_grid()
	pass

func _process(delta):
	pass
	
func generate_grid() -> void:
	for x in grid_size.x:
		for y in grid_size.y:	
			var cell:GridCell = GRID_CELL.instantiate()
			cell.pos = Vector2(x * grid_cell_size.x, y * grid_cell_size.y)
			cell.position = cell.pos
			cell.name = str(Vector2(x, y))
			add_child(cell)
			
func get_cell(pos:Vector2) -> GridCell:
	var cell_name:String = str(pos)
	print(get_node(cell_name))
	if get_node(cell_name):
		return get_node(cell_name)
	else:
		return null
	
