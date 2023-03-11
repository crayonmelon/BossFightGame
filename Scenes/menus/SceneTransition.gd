extends CanvasLayer

func change_scene(target: String, anim = "disolve") -> void:
	$AnimationPlayer.play(anim)
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards(anim)

func change_scene_dialog_intro(target: String, text) -> void:
	$AnimationPlayer.play("anim")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("anim")
