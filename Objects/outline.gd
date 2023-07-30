class_name Outline extends Node2D

@export var selected:bool = false
var prev_selected:bool = selected
@export var direction:Vector2i = Vector2i.UP
@onready var tilemap:TileMap = get_tree().current_scene.get_node("Collision")

func update(target_pos:Vector2, position:Vector2, state:Entity.entityState) -> void:
	
	visible = GridHelper.is_valid_movement(tilemap, GridHelper.get_cell_pos_in_tilemap(tilemap, position)+direction, GridHelper.get_cell_pos_in_tilemap(tilemap, position)) && global_position.x > 32 && global_position.y < 480 && global_position.y > 32 && global_position.x < 480
	
	if direction.length() > 1 and state == Entity.entityState.ATTACK:
		hide()
	
	
	if prev_selected != selected:
		update_selection()
	prev_selected = selected
	
func update_selection() -> void:
	
	if selected:
		$AnimationPlayer.play("selected")
	else:
		$AnimationPlayer.play("idle")

func select() -> void:
	$AnimationPlayer.play("selected")
	
func deselect() -> void:
	$AnimationPlayer.play("idle")
	
func set_color(target_color:Color):
	$Sprite2D.modulate = target_color
