extends Sprite3D

@export var speed = 100
@export var direction = Vector3.LEFT

func _physics_process(delta):
	
	position += direction * delta * speed
	pass
