extends PathFollow3D

@export var speed = 1.5

func _process(delta):
	progress += delta * speed
	pass
