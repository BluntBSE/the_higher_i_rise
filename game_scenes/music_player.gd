extends Node
class_name MusicPlayer

@export var asp:AudioStreamPlayer

var track_list = {
	"air_in_time": "res://godot/imported/air_in_time.mp3-7e9bd8a1daadd8c6480e42d6fb626b0b.mp3str"
}


func play_song(song:String):
	var audiostream = track_list[song]
	audiostream = ResourceLoader.load(audiostream)
	print(audiostream)
	asp.stream = audiostream
	asp.playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
