extends Node
class_name TheGlory

#Background Nodes
@export var music_player:MusicPlayer
@export var sfx_player:SFXPlayer

#Sound Settings
@export var current_volume: int  = 100
#Graphic Settings
@export var scene_type = "main_menu" #"main_menu", "main_game"
#Bird/Worm
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene_type == "main_menu":
		music_player.play_song("air_in_time")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
