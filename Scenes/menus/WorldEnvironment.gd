extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _set_color():
	var colorOne = Color(.68, randf_range(0,1), .68, 1)
	var colorTwo = Color(randf_range(0,1), .49, .67, 1)
	
	environment.sky.sky_material.set("sky_horizon_color",colorTwo)
	environment.sky.sky_material.set("sky_horizon_color",colorOne)
	
	environment.sky.sky_material.set("ground_bottom_color", colorTwo)
	environment.sky.sky_material.set("ground_horizon_color", colorOne)
	
 
