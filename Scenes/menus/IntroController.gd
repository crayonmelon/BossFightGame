extends Node

var animPlayed = false

func start_anim():
	$AnimationPlayer.play("intro_anim")
	await  $AnimationPlayer.animation_finished
	
