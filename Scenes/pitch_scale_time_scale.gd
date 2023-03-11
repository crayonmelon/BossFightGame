extends AudioStreamPlayer
@onready var gameManager = get_node("/root/GAMEMANAGER")
func _ready():
	#gameManager._time_scale_changed.connect(_time_scale)
	pitch_scale = 1
	print(pitch_scale)

func _time_scale():
	pitch_scale = Engine.time_scale
	print("wow")
	pass
