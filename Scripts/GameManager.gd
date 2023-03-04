class_name GAMEMANAGER
extends Node

@export var testing = true

@export var lives = 4
@export var points = 0


@export var LEVELS: Array[Resource]

@onready var level_container = $LevelContainer
@onready var timer = $Timer

@onready var animation_player = $LevelArea/AnimationPlayer 

#Camera Time
@onready var main_camera = $LevelArea/MainCamera
@onready var transition_camera = $LevelArea/transitionContainer/SubViewport/TransitionCamera
@onready var transition_container = $LevelArea/transitionContainer

var level_camera 

var transition_time = 3

func _ready():
	if !testing:
		_transisition()
	pass

func _transisition():
	
	print("anim")
	
	if level_container.get_child_count() > 0:
		level_container.get_child(0).queue_free()
		_camera_transition_effect(camera.MAIN)
		
	else:
		_change_camera(camera.MAIN)
	
	animation_player.play("TransistionEffect")
	await animation_player.animation_finished
	print("anim_over")
	
	_next_level()
	pass

func _failed():
	
	lives -= 1
	_transisition()

func _success():
	
	points += 1
	_transisition()

func _next_level():
	var level = LEVELS[randi() % LEVELS.size()].instantiate()
	level_camera = level.get_node("Camera3D")
	level_container.add_child(level)
	_camera_transition_effect(camera.LEVEL)
	

#Param is the camera to transition to 
func _camera_transition_effect(camera_type):
	
	transition_camera.global_position = main_camera.global_position if(camera_type == camera.LEVEL) else level_camera.global_position
	transition_camera.global_rotation = main_camera.global_rotation if(camera_type == camera.LEVEL) else level_camera.global_rotation
	
	var tween_pos = create_tween()
	var tween_rot = create_tween()
	
	var to_pos = level_camera.global_position if(camera_type == camera.LEVEL) else main_camera.global_position
	var to_rot = level_camera.global_rotation if(camera_type == camera.LEVEL) else main_camera.global_rotation
	
	tween_pos.tween_property(transition_camera,"position", to_pos, 1).set_trans(Tween.TRANS_ELASTIC)
	tween_rot.tween_property(transition_camera,"rotation", to_rot, 1).set_trans(Tween.TRANS_ELASTIC)
	transition_container.visible = true
	$LevelArea/transitionContainer/TransisitonAnim.play("transition_anim")
	
	_change_camera(camera.TRANS)
	await tween_pos.finished
	
	_change_camera(camera.LEVEL if(camera_type == camera.LEVEL) else camera.MAIN )

	transition_container.visible = false

# Camera syntax Sugar
enum camera {MAIN, LEVEL, TRANS}

func _change_camera(camera_type):
	
	main_camera.current = false
	if level_camera != null:
		level_camera.current = false
	transition_camera.current = false
	
	if camera_type == camera.MAIN:
		main_camera.current = true
		
	elif  camera_type == camera.LEVEL:
		level_camera.current = true
		
	elif camera_type == camera.TRANS:
		transition_camera.current = true
	else:
		print("SOMETHING HAS FUCKED UP WITH THE CAMERAS")
		main_camera.current = true
		
