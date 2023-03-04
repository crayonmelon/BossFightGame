class_name Level

extends Node3D

@onready var gameManager = get_node("/root/Gamemanager")
@onready var timer = Timer.new()

var level_time = 3

func _ready():
	
	timer.timeout.connect(_lose)
	timer.wait_time = level_time
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _process(delta):
	pass

func _win():
	gameManager._success()
	pass

func _lose():
	
	gameManager._failed()
	pass
