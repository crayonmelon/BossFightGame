class_name Interactable
extends StaticBody3D

var entered = false
@onready var gameManager = get_node("/root/GAMEMANAGER")

func _ready():
	mouse_entered.connect(func() : entered = true)
	mouse_exited.connect(func() : entered = false)

func _input(event):
	if event.is_action_pressed("interact") && entered:
		$"../.."._win()
