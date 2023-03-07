extends Node3D


func _process(delta):

	
	pass

func _on_pointer_static_area_entered(area):
	print("entered")
	print(area.name)
	pass  


func _on_pointer_static_body_entered(body):
	print(body.name)
	pass # Replace with function body.
