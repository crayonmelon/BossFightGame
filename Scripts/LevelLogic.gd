class_name Level
extends Node3D

@export var level_time = 5
@export var timeInf = false
@export var time_over_win = false 

@onready var gameManager = get_node("/root/GAMEMANAGER")
@onready var timer = Timer.new()

@onready var instructions_anim = $CanvasLayer/AnimationPlayer
@onready var game_container = $GameContainer

enum STATE {OPENING ,PLAYING, FAILED, WON}
var current_state = STATE.OPENING
var difficulty

func _ready():
	instructions_anim.play("text_anim")
	
	await instructions_anim.animation_finished
	#unpause
	current_state = STATE.PLAYING
	timer.timeout.connect(_lose if !time_over_win else _win)
	timer.wait_time = level_time
	timer.one_shot = true
	add_child(timer)
	
	if !timeInf:
		timer.start()

func _win():
	
	if current_state == STATE.PLAYING || current_state == STATE.OPENING:
		timer.stop()
		
		if $AnimationSuccess != null:
			$AnimationSuccess.play("anim_success")
			await $AnimationSuccess.animation_finished
			
		current_state = STATE.WON
		gameManager._success()

func _lose():
	
	if current_state == STATE.PLAYING or current_state == STATE.OPENING:
		
		current_state = STATE.FAILED
		gameManager._failed()
