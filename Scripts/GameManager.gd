class_name GAMEMANAGER
extends Node

@export var testing = true
#Score 
@export var lives = 4
@export var points = 0
@export var difficulty = 0
@export var round = 0
@export var time_scale = 1.0

@onready var points_text = $CanvasLayer/points
@onready var lives_text = $CanvasLayer/lives
 
@export var final_level : Resource

@export var LEVELS: Array[Resource]
@export var BEATS: Array[AudioStream]

@export var did_bad = ["hey, WTF", "hey, imma freak", "hey, are you trying?", "hey, fuck you", "hey, (_)_)::::D", "Lol, lmao even"]
@export var did_good = ["hey, goodjob!", "hey, I'm so proud", "hey, promotion for you", "Wowzers, awooga"]

@onready var level_container = $LevelContainer
@onready var timer = $Timer

@onready var animation_player = $LevelArea/AnimationPlayer 
@onready var pc_sound = $LevelArea/AnimationPlayer/AudioStreamPlayer

#Camera Time
@onready var main_camera = $LevelArea/MainCamera
@onready var transition_camera = $LevelArea/transitionContainer/transitionViewport/TransitionCamera
@onready var transition_container = $LevelArea/transitionContainer

@onready var level_data = $LevelArea/Main_area/crtbody/ScreenNode/screenViewport/LevelData
@onready var boss_message = $LevelArea/Main_area/BossText/LevelBack/SubViewport/RichTextLabel

signal _time_scale_changed(val)

var level_camera 
var transition_time = 3

func _ready():
	if !testing:
		_first_time()
		
	else:
		main_camera.current = false
		transition_camera.current = false
		
func _time_scale_change():
	time_scale += .1
	Engine.time_scale = time_scale
	_time_scale_changed.emit()
	
	boss_message.set_text("GONNA SPEED IT UP")
	#spectrum.pitch_scale = time_scale

func _first_time():
	_transisition()

func _transisition():
	if points % 5==0 and points != 0: 
		_time_scale_change()
	
	music_change()
	points_text.text = str(points)+ ("/"+str(Globals.ENDING_POINTS_NEEDED) if Globals.CURRENT_GAMEMODE == Globals.GAMEMODES.STORY else "")
	lives_text.text = str(lives)
	
	if level_container.get_child_count() > 0:
		_camera_transition_effect(camera.MAIN)
		
		for n in level_container.get_children():
			level_container.remove_child(n)
			n.queue_free()
		
	else:
		_change_camera(camera.MAIN)
	
	level_data.visible = true
	var level = LEVELS[_random_level()].instantiate()
	
	#FINAL LEVEL
	if points >= Globals.ENDING_POINTS_NEEDED && Globals.CURRENT_GAMEMODE == Globals.GAMEMODES.STORY:
		level = final_level.instantiate()
	
	animation_player.play("TransistionEffect")
	await animation_player.animation_finished
	
	$WorldEnvironment._set_color()
	
	level_camera = level.get_node("Camera3D")
	level_container.add_child(level)
	_camera_transition_effect(camera.LEVEL)
	pass

func music_change():
	pc_sound.stop()
	var sfx = load(BEATS[randi() % BEATS.size()].resource_path) 
	pc_sound.stream = sfx
	pc_sound.play()
	
	await pc_sound.finished
	
	pc_sound.stop()
	pc_sound.stream = preload("res://Audio/DrumBeat/beat_loop.wav")
	pc_sound.play()
	pass

func _failed():
	$LevelArea/FailAudio.play()
	lives -= 1
	_check_if_lost()
	points += 1
	boss_message.set_text(did_bad[randi() % did_bad.size()])
	_transisition()

func _success():
	points += 1
	Globals.CURRENT_SCORE = points
	boss_message.set_text(did_good[randi() % did_good.size()])
	_transisition()

func _check_if_lost():
	if lives <=0:
		Transition.lost_transition(self)

func _next_level():
	var level = LEVELS[_random_level()].instantiate()
	level_camera = level.get_node("Camera3D")
	level_container.add_child(level)
	_camera_transition_effect(camera.LEVEL)
	
#Param is the camera to transition to 
func _camera_transition_effect(camera_type):

	level_data.visible = false

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
		
	elif camera_type == camera.LEVEL and level_camera != null:
		level_camera.current = true
		
	elif camera_type == camera.TRANS:
		transition_camera.current = true
	else:
		main_camera.current = true
		
var past_level = -1

func _random_level():
	
	if points == 0:
		return 0
	
	var ran_val = past_level
	while (ran_val == past_level) : 
		ran_val = randi() % LEVELS.size()
		print(ran_val)
	
	past_level = ran_val
	return ran_val
	pass
