extends Node

var anims = ["intro_anim", "intro_anim_2","intro_anim_3","intro_anim_4","intro_anim_5", "intro_anim_6", "intro_anim_7","intro_anim_8", "intro_anim_9", "intro_anim_10", "intro_anim_11"]
var offset = 0

var animPlayed = false

func _start_cutscene():
	$AudioStreamPlayer.play()
	_anin_play()

func _anin_play():
	
	animPlayed = false
	if offset == anims.size():
		_loadgame()
		return

	$AnimationPlayer.play(anims[offset])
	
	await $AnimationPlayer.animation_finished
	animPlayed = true
	offset+=1

func _input(event):
	if event.is_action_pressed("interact") && animPlayed:

		_anin_play()

func _loadgame(): 
	$AudioStreamPlayer.stop()
	$AnimationPlayer.play("intro_anim_final")
	get_tree().change_scene_to_file("res://Scenes/menus/GAMEMANAGER.tscn")
