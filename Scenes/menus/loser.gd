extends Node
@onready var fired = $fired
@onready var score = $score
@onready var sprite_2d = $Sprite2D

var loss = false

func _ready():
	set_visible(false)

func set_visible(val):
	loss = val
	fired.visible = val
	score.visible = val
	sprite_2d = val

func _lose():
	$"..".update_score_highscore()
	set_visible(true)
	score.text = "SCORE: "+str(Globals.CURRENT_SCORE) + "\n" + "H-SCORE: " + str(Globals.HIGHSCORE) 
	$AnimationPlayer.play("loss_anim")
	$AudioStreamPlayer.play()
	
func _input(event):
	if event.is_action_pressed("interact") && loss:
		set_visible(false)

		$AnimationPlayer.play_backwards("loss_anim")
		$"..".load_menu()
