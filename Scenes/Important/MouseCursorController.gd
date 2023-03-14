extends Node

var icon_pointer = preload("res://Sprites/cursors/finger.png")
var icon_click = preload("res://Sprites/cursors/thumbsUp.png")
var icon_grab = preload("res://Sprites/cursors/grab.png")

func pointer():
	Input.set_custom_mouse_cursor(icon_click, 1, Vector2(14,0))

func selected():
	Input.set_custom_mouse_cursor(icon_pointer, 0, Vector2(14,0))
		
func highlight():
	Input.set_custom_mouse_cursor(icon_grab, 0, Vector2(14,0))


func _input(event):
	if event.is_action_pressed("interact"):
		selected()
		
	if event.is_action_released("interact"):
		pointer()
