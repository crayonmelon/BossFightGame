extends Button

func _ready():
	if !Globals.HARDMODE_UNLOCKED:
		queue_free()
