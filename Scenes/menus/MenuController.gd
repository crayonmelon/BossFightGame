extends Node3D


func _on_startgame_pressed():
	Transition.change_scene_dialog_intro("res://Scenes/menus/GAMEMANAGER.tscn",self)
	
	pass 
