extends Node3D
var caught = false

func _input(event):
	if event.is_action_pressed("interact"):
		$fishingRod/AnimationPlayer.play("fishin_rod")
		

func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("interact") and !caught:
		_fish_caught()

func _fish_caught():
	
	caught = true
	$Path3D/PathFollow3D/fish.queue_free()
	$".."._win()

func _on_static_body_3d_mouse_entered():
	MouseCursorController.highlight()

func _on_static_body_3d_mouse_exited():
	MouseCursorController.selected()

