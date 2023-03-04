class_name GAMEMANAGER
extends Node

@export var testing = true

@export var lives = 4
@export var LEVELS: Array[Resource]

@onready var level_container = $LevelContainer
@onready var timer = $Timer
var transition_time = 3

@onready var animation_player = $LevelArea/AnimationPlayer

func _ready():
	if !testing:
		_transisition()
	pass

func _transisition():
	
	print("anim")
	
	if level_container.get_child_count() > 0:
		level_container.get_child(0).queue_free()
		
	animation_player.play("TransistionEffect")
	await animation_player.animation_finished
	print("anim_over")
	
	_next_level()
	pass

func _failed():
	
	lives -= 1
	
	_transisition()
	pass

func _success():
	
	_transisition()
	pass

func _next_level():
	level_container.add_child(LEVELS[randi() % LEVELS.size()].instantiate())
