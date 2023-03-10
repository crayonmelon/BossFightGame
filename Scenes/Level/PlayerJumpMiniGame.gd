extends Node3D

@onready var player_area = $PlayerArea
@onready var player_anim = $PlayerArea/AnimationPlayer
var lost = false

func _input(event):
	if event.is_action_pressed("interact"):
		_jump()

func _jump():
	if !player_anim.is_playing() and !lost:
		player_anim.play("jump")

func _on_static_body_3d_area_entered(area):
	player_anim.play("car_hit")
	await player_anim.animation_finished
	$".."._lose()
