extends StaticBody3D

@export var angle = Vector3.LEFT
@onready var gameManager = get_node("/root/Gamemanager")

var entered = false
var spinning = true

var degrees_per_second = 360.0

func _ready():
	mouse_entered.connect(func() : entered = true)
	mouse_exited.connect(func() : entered = false)

func _process(delta):
	
	if spinning:
		rotate(angle, delta * deg_to_rad(degrees_per_second))

func _input(event):
	if event.is_action_pressed("interact") && entered:
		spinning = false
