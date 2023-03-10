extends MeshInstance3D

func _ready():
	get_active_material(0).set("albedo_color", Color(randf_range(0.0,1.0), randf_range(0.0,1.0), randf_range(0.0,1.0), 1.0))
	pass


func _process(delta):
	pass
