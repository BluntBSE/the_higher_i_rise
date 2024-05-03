extends Node
class_name SFXPlayer

@export var asp:AudioStreamPlayer
@export var glory:TheGlory
@export var db_offset = float(10.0)

func play_sfx(audio_stream):
	var stream = AudioStreamPlayer.new()
	glory.add_child(stream)
	stream.stream = audio_stream
	stream.volume_db = float(glory.sfx_volume) - db_offset
	stream.playing = true
	await stream.finished
	stream.queue_free()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
