extends Node3D
var ball = preload("res://Scenes/ball.tscn")

func _input(event):
	if event.is_action_pressed("interact"):
		_spawn_ball()

func _spawn_ball():
	var b = ball.instantiate()
	b.global_position = global_position
	get_tree().root.add_child(b)
