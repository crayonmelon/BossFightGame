extends CanvasLayer

func _ready():
	#change_scene_dialog_intro("res://Scenes/menus/GAMEMANAGER.tscn");
	pass

func change_scene(target: String, scene) -> void:
	Globals._time_scale_reset()
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	scene.queue_free()
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")


func change_scene_dialog_intro(target: String, scene) -> void:
	Globals._time_scale_reset()
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	scene.queue_free()
	$Intro._start_cutscene()

func lost_transition(scene) -> void:
	Globals._time_scale_reset()
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	scene.queue_free()	
	$Lose._lose()

func won_transition(scene) -> void:
	Globals._time_scale_reset()
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	scene.queue_free()	
	$Win._won()
	
func load_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/menus/mainMenu.tscn")
	$AnimationPlayer.play_backwards("dissolve")

func update_score_highscore() -> void: 
	if Globals.CURRENT_SCORE > Globals.HIGHSCORE:
		Globals.HIGHSCORE = Globals.CURRENT_SCORE
