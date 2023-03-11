extends Node

var animPlayed = false

var introScene = []
var offset = 0

func _ready():
	for N in get_children():
		introScene.push_front(N)
	
	start_anim()
	
func start_anim():
	if offset == introScene.size():
		return
	
	var tween_text = create_tween()
	var tween_image = create_tween()
	
	tween_text.tween_property(introScene[offset].get_node("IntroText"),"modulate", Color(1, 1, 1, 1), 1).set_trans(Tween.TRANS_ELASTIC)
	tween_image.tween_property(introScene[offset].get_node("introImage"),"material:shader_parameter/offset", 0, 1).set_trans(Tween.TRANS_ELASTIC)
	
	#introScene[offset].get_node("AnimationPlayer").play("intro_anim")
	#await introScene[offset].get_node("AnimationPlayer").animation_finished
	animPlayed = true

func _input(event):
	if event.is_action_pressed("interact") && animPlayed:
		animPlayed = false
		offset += 1
		start_anim()
