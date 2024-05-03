extends ColorRect
var is_open = false
@export var volume_number:RichTextLabel
@export var sfx_vol:RichTextLabel
@export var glory:TheGlory #Singleton for configuration variables

func _on_music_volume_changed(volume):
	var number = ( volume + 20 )* 5
	var output = "[center]" + str (number) + "[/center]"
	volume_number.text = output
	
func _on_sfx_volume_changed(volume):
	var number = ( volume + 20 )* 5
	var output = "[center]" + str (number) + "[/center]"
	sfx_vol.text = output
	
func on_open():
	_on_music_volume_changed(glory.music_volume)
	_on_sfx_volume_changed(glory.sfx_volume)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	glory = get_tree().root.get_node("the_glory")
	glory.music_volume_changed.connect(_on_music_volume_changed)
	glory.sfx_volume_changed.connect(_on_sfx_volume_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
