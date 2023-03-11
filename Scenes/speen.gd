extends Node3D
@export var angle = Vector3.LEFT
@export var degrees_per_second = 360.0

@export var randomiser = false


func _ready():
	if randomiser:
		degrees_per_second = degrees_per_second *  (-1 if randi() % 2 == 0 else 1)
	
	print(degrees_per_second)
	
func _process(delta):
	rotate(angle, delta * deg_to_rad(degrees_per_second))
	pass
