extends Node3D
@onready var path_follow_3d = $Path3D/PathFollow3D

var brick_entered = false
var punched = false
var succeeded = false

func _ready():
	var t = randf_range(0,1)
	await get_tree().create_timer(t).timeout
	throw_brick()
	pass 

func punch():
	
	if punched:
		return
	
	$arm/AnimationPlayer.play("punch")
		
	if brick_entered:
		return_brick()
	
	punched = true
	
func _input(event):
	if event.is_action_pressed("interact"):
		punch()

func _on_player_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	brick_entered = true
	$Path3D/PathFollow3D/Brick/Sprite3D/AnimationPlayer.play("indicator")
	
func _on_player_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	brick_entered = false

func return_brick():
	succeeded = true
	$Path3D/PathFollow3D/Brick/white/AnimationPlayer.play("flash")
	$Path3D/PathFollow3D/Brick/AnimationPlayer.play_backwards("brick_travel")
	
	await $Path3D/PathFollow3D/Brick/AnimationPlayer.animation_finished
	$cat/AnimationPlayer.play("explode")
	
	await $cat/AnimationPlayer.animation_finished
	$".."._win()


func throw_brick():

	$Path3D/PathFollow3D/Brick/AnimationPlayer.play("brick_travel")
	await $Path3D/PathFollow3D/Brick/AnimationPlayer.animation_finished
	
	if !succeeded:
		$".."._lose()
		
	
