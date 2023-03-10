extends Node3D

var mouse_entered_maze = true
var mouse_entered_start = false
var can_follow = false

@onready var sub_viewport = $Sprite3D/SubViewport
@onready var icon = $"../CanvasLayer/iconBody"
var starting_point = Vector2(26,152)
@onready var audio_stream_player = $AudioStreamPlayer
@onready var error = preload("res://Audio/error/error_2.ogg")
@onready var success = preload("res://Audio/success/success_5.ogg")

func _ready():
	pass 

func _process(delta):

	if !mouse_entered_maze and !mouse_entered_start:
		can_follow = false
	
	if mouse_entered_maze and can_follow:
		icon.position.x = get_viewport().get_mouse_position().x
		icon.position.y = get_viewport().get_mouse_position().y
	else:
		icon.position = starting_point


func _on_static_body_3d_mouse_entered():
	mouse_entered_maze = true

func _on_static_body_3d_mouse_exited():
	mouse_entered_maze = false
	audio_stream_player.stream = error
	audio_stream_player.play()

func _input(event):
	if event.is_action_pressed("interact"):
		pass

func _on_start_body_mouse_entered():
	mouse_entered_start = true
	can_follow = true
	audio_stream_player.stream = success
	audio_stream_player.play()
	
func _on_start_body_mouse_exited():
	mouse_entered_start = false

func _on_area_2d_area_entered(area):
	$".."._win()
