extends MeshInstance3D

@onready var spectrum = AudioServer.get_bus_effect_instance(1, 0)
var volume

func _ready():
	
	pass 

func _process(delta):
	
	volume = clamp(spectrum.get_magnitude_for_frequency_range(60, 11050).length()/.05,0,.9)
	get_active_material(0).set_shader_parameter("jitter",volume)
	
	pass
