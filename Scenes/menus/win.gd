extends Node

var won = false
@onready var fired = $fired
@onready var score = $score
@onready var bg = $BG
@onready var fire = $FIRE
@onready var fire_2 = $FIRE2
@onready var fire_3 = $FIRE3

func _ready():
	set_visible(false)

func set_visible(val):
	won = val
	fired = val
	score = val
	bg = val
	fire = val
	fire_2 = val
	fire_3 = val
	
func _won():
	$"..".update_score_highscore()
	set_visible(true)
	$AnimationPlayer.play("won")
	$AudioStreamPlayer.play()
	
func _input(event):
	if event.is_action_pressed("interact") && won:
		set_visible(false)

		$AnimationPlayer.play_backwards("won")
		$"..".load_menu()
