extends Node3D

var anims_set_1 = ["talk", "talk_2", "talk_3", "talk_4", "talk_5", "talk_6"]
var anims_set_2 = ["talk__Second_1"]
var anims_set_3 = ["talk_final", "talk_final_2", "talk_final_3", "talk_final_5", "talk_final_6", "talk_final_7", "talk_final_8", "talk_final_9", "talk_final_10", "talk_final_11", "talk_final_12"]
var anims = []
var offset = 0

var throw_speed = 1

@onready var dialogue_player = $EvanBoss/AnimationPlayer

var animPlayed = false

var brick_entered = false
var punched = false
var can_punch = false
var brick_returned = false

func _start_dialogue(target):
	anims = target
	offset = 0
	_start_cutscene()
	pass

func _ready():
	_start_dialogue(anims_set_1)
	
func _start_cutscene():
	_anin_play()

func _anin_play():
	if offset == anims.size():
		return
	animPlayed = false
	dialogue_player.play(anims[offset])
	
	await dialogue_player.animation_finished
	animPlayed = true
	offset+=1
	
	if offset == anims.size():
		_brick_event()
	return

func _input(event):
	if event.is_action_pressed("interact"):
		
		if can_punch:
			$arm/AnimationPlayer.play("punch")
			
			if brick_entered:
				return_entered()
			
		if animPlayed:
			_anin_play()
		
func _brick_event():
	if throw_speed > 1.5:
		if !can_punch:
			Globals.HARDMODE_UNLOCKED = true
			Transition.won_transition(get_node("/root/GAMEMANAGER"))
		else:
			_ending()
			
		can_punch = false
		return
	
	brick_returned = false
	can_punch = true
	$Path3D/PathFollow3D/Brick/AnimationPlayer.play("brick_speen")
	$Path3D/PathFollow3D/Brick/AnimationPlayer.speed_scale = throw_speed
	await $Path3D/PathFollow3D/Brick/AnimationPlayer.animation_finished
	
	if !brick_returned:
		$".."._lose()
	
func _ending():
	_start_dialogue(anims_set_3)
	pass

func _on_player_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Path3D/PathFollow3D/Brick/Sprite3D/AnimationPlayer.play("indicator")
	brick_entered = true

func return_entered():
	brick_returned = true
	$Path3D/PathFollow3D/Brick/white/AnimationPlayer.play("flash")
	$Path3D/PathFollow3D/Brick/AnimationPlayer.play_backwards("brick_speen")
	
	await $Path3D/PathFollow3D/Brick/AnimationPlayer.animation_finished
	throw_speed += .2
	_start_dialogue(anims_set_2)
	

func _on_player_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	brick_entered = false
	pass # Replace with function body.
