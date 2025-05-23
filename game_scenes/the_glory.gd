extends Node
class_name TheGlory

#Background Nodes
@export var music_player:MusicPlayer
@export var sfx_player:SFXPlayer
#Sound Settings
signal music_volume_changed(music_volume)
@export var music_volume: int = -10
signal sfx_volume_changed(sfx_volume)
@export var sfx_volume: int = 0
#Graphic Settings
@export var scene_type = "main_menu" #"main_menu", "main_game"
#Bird/Worm

var pages = 1 #every time the player clicks an option, pages increments by 1. This is to establish relative distance in remembering.

#var the_history = {}#this huge dictionary contains all the interaction keys the player has visited, along with the memories and aspects they had at the time.
var the_history = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene_type == "main_menu":
		music_player.play_song("air_in_time")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
