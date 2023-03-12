extends CanvasLayer

func _ready():
	#change_scene_dialog_intro("res://Scenes/menus/GAMEMANAGER.tscn");
	pass

func change_scene(target: String,  anim = "disolve") -> void:
	$AnimationPlayer.play(anim)
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards(anim)

func change_scene_dialog_intro(target: String, scene) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	scene.queue_free()
	$Intro._start_cutscene()
