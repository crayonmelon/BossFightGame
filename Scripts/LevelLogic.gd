class_name Level

extends Node3D

@onready var gameManager = get_node("/root/Gamemanager")
@onready var timer = Timer.new()

enum STATE {OPENING ,PLAYING, FAILED, WON}
var current_state = STATE.OPENING

var level_time = 3

func _ready():
	
	current_state = STATE.PLAYING
	timer.timeout.connect(_lose)
	timer.wait_time = level_time
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _process(delta):
	pass

func _win():
	
	if current_state == STATE.PLAYING:
		
		current_state = STATE.WON
		gameManager._success()

func _lose():
	
	if current_state == STATE.PLAYING:
		
		current_state = STATE.FAILED
		gameManager._failed()
