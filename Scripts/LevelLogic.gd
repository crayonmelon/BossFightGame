class_name Level
extends Node3D

@export var level_time = 5

@onready var gameManager = get_node("/root/Gamemanager")
@onready var timer = Timer.new()

@onready var instructions_anim = $CanvasLayer/AnimationPlayer
@onready var game_container = $GameContainer

enum STATE {OPENING ,PLAYING, FAILED, WON}
var current_state = STATE.OPENING
var difficulty

func _ready():
	#pause
	instructions_anim.play("text_anim")
	
	await instructions_anim.animation_finished
	#unpause
	current_state = STATE.PLAYING
	timer.timeout.connect(_lose)
	timer.wait_time = level_time
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _process(delta):
	pass

func _win():
	
	if current_state == STATE.PLAYING || current_state == STATE.OPENING:
		
		current_state = STATE.WON
		gameManager._success()

func _lose():
	
	if current_state == STATE.PLAYING or current_state == STATE.OPENING:
		
		current_state = STATE.FAILED
		gameManager._failed()
