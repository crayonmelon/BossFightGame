extends Node2D


func _process(delta):
	global_position.x = get_viewport().get_mouse_position().x
	global_position.y = get_viewport().get_mouse_position().y
