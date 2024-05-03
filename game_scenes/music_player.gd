extends Node
class_name MusicPlayer

@export var asp:AudioStreamPlayer
var glory
@export var db_offset = float(10.0)

var track_list = {
	"air_in_time": "res://godot/imported/air_in_time.mp3-7e9bd8a1daadd8c6480e42d6fb626b0b.mp3str",
	"shadow_journal": "res://godot/imported/shadow_journal.mp3-0d08f12408cebaf1fbcc6a8d1de59e3b.mp3str"
}


func play_song(song:String):
	var audiostream = track_list[song]
	audiostream = ResourceLoader.load(audiostream)
	asp.stream = audiostream
	asp.playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	glory = get_parent()
	glory.music_volume_changed.connect(_on_the_glory_music_volume_changed)
	asp.volume_db = float(glory.music_volume) - db_offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Should I wait on signal instead of updating volume perpetually? Probably.
	pass
	


func _on_the_glory_music_volume_changed(music_volume):
	asp.volume_db = float(music_volume) - db_offset
	if music_volume == -20:
		asp.playing = false
	if asp.playing == false:
		if music_volume != -20:
			asp.playing = true
		
	pass # Replace with function body.
