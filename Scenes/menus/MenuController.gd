extends Node3D

func _ready():
	Globals._time_scale_reset()

func _on_startgame_pressed():
	Globals.CURRENT_GAMEMODE = Globals.GAMEMODES.STORY
	Globals.ENDING_POINTS_NEEDED = 25
	Transition.change_scene_dialog_intro("res://Scenes/menus/GAMEMANAGER.tscn",self)

func _on_infinite_mode_pressed():
	Globals.CURRENT_GAMEMODE = Globals.GAMEMODES.ENDLESS
	Transition.change_scene("res://Scenes/menus/GAMEMANAGER.tscn", self)

func _on_hardmode_pressed():
	Globals.CURRENT_GAMEMODE = Globals.GAMEMODES.STORY
	Globals.ENDING_POINTS_NEEDED = 100
	Transition.change_scene_dialog_intro("res://Scenes/menus/GAMEMANAGER.tscn",self)
	pass # Replace with function body.
