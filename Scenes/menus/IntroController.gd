extends Node

var animPlayed = false
@export var Sprites: Array[Sprite2D]
@export var Text: Array[String]

@onready var press_skip = $"../PressSkip"

var introScene = []
var offset = 0


func _ready():
	for N in get_children():
		introScene.push_front(N)
		
	_start_intro()
	
func _start_intro():
	next_slide_dittter(offset)
	
func next_slide_dittter(num, reverse = false, image_ditter = true, speed = 1.0):
	
	var tween_text = create_tween()
	var tween_image = create_tween()
	
	tween_text.tween_property(introScene[num].get_node("IntroText"),"modulate", Color(1, 1, 1, 1 if !reverse else 0), speed).set_trans(Tween.TRANS_ELASTIC)
	
	if image_ditter:
		tween_image.tween_property(introScene[num].get_node("introImage"),"material:shader_parameter/offset", 0 if !reverse else 1, speed).set_trans(Tween.TRANS_ELASTIC)
	else:
		introScene[num].get_node("introImage").get_material().set_shader_parameter("offset",0)
		
	await tween_text.finished
	
	#NEXT SLIDE
	if reverse:
		introScene[num].get_node("introImage").visible = false
		offset+=1
		
		if offset == introScene.size():
			_end()
			return
		
		next_slide_dittter(offset, false, introScene[offset].intro_ditter, introScene[offset].trans_speed)
		return

	animPlayed = true
	press_skip.visible = animPlayed
	
	
func _input(event):
	if event.is_action_pressed("interact") && animPlayed:
		animPlayed = false
		press_skip.visible = animPlayed
		#REMOVE SLIDE
		next_slide_dittter(offset, true, introScene[offset].outro_ditter, introScene[offset].trans_speed)
		
		
func _end():
	print("done")
	$"../AnimationPlayer".play_backwards("dissolve")
	get_tree().change_scene_to_file("res://Scenes/menus/GAMEMANAGER.tscn")

	pass
