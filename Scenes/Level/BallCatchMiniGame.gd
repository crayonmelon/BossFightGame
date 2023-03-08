extends Node3D

@export var ballCount = 0
@export var ballsLeft = 6
@export var ballsNeeded = 1

#TEXT
@onready var balls_entered = $HEadPath/PathFollow3D/lady/Sprite3D/SubViewport/BallsEntered
@onready var balls_left = $BallDropper/PathFollow3D/Node3D/Sprite3D/SubViewport/BallsLeft

@onready var ball_spawner = $BallDropper/PathFollow3D/Node3D

var ball = preload("res://Scenes/ball.tscn")

func _ready():
	balls_entered.set_text("[center]" + str(ballCount) + "/" + str(ballsNeeded))
	balls_left.set_text("[center]" + str(ballsLeft))

func _on_area_3d_body_entered(body):
	if body.get_collision_layer() == 1:
		ballCount += 1
		balls_entered.set_text("[center]" + str(ballCount) + "/" + str(ballsNeeded))
		
		if ballCount == ballsNeeded:
			_win()

func _on_area_3d_body_exited(body):
	
	if body.get_collision_layer() == 1:
		ballCount -= 1
		balls_entered.set_text("[center]" + str(ballCount) + "/" + str(ballsNeeded))


func _input(event):
	if event.is_action_pressed("interact") && ballsLeft >= 0:
		
		_spawn_ball()

func _spawn_ball():
	
	ballsLeft-=1
	
	balls_left.set_text("[center]" + str(ballsLeft))
	
	var b = ball.instantiate()
	b.global_position = ball_spawner.global_position
	get_tree().root.add_child(b)


func _win(): 
	$".."._win()
