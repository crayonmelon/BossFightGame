extends Node3D

@export var angle = Vector3.LEFT
@onready var gameManager = get_node("/root/Gamemanager")
@export var degrees_per_second = 360.0

var spinning = true
var entered = false

func _process(delta):
	if spinning:
		rotate(angle, delta * deg_to_rad(degrees_per_second))

func _input(event):
	if event.is_action_pressed("interact"):
		spinning = false
		
		if entered: 
			$"../.."._win()
		else:
			$"../.."._lose()

func _on_pointer_static_area_entered(area):
	if area.name == "targetFella":
		entered = true
	pass


func _on_pointer_static_area_exited(area):
	if area.name == "targetFella":
		entered = false
	pass
