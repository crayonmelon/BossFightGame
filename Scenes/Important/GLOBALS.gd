extends Node

enum GAMEMODES {STORY, ENDLESS}
@export var CURRENT_GAMEMODE : GAMEMODES
@export var ENDING_POINTS_NEEDED = 25
@export var HIGHSCORE = 25
@export var CURRENT_SCORE = 0

@export var DELTATIME = 1

@export var HARDMODE_UNLOCKED = false

func _time_scale_reset():
	Engine.time_scale = 1
