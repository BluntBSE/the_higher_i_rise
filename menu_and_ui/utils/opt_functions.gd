extends Node
class_name OptFunctions

#These menus are starting to look like they should all be a shared class...Let's see if we make more than start + opts
static func reduce_music_volume(node:Node, increment:int):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")
	glory.music_volume -= increment
	glory.music_volume = clamp(glory.music_volume, -20,0)
	glory.music_volume_changed.emit(glory.music_volume)

static func add_music_volume(node:Node, increment:int):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")
	glory.music_volume += increment
	glory.music_volume = clamp(glory.music_volume, -20,0)
	glory.music_volume_changed.emit(glory.music_volume)
	
static func reduce_sfx_volume(node:Node, increment:int):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")
	glory.sfx_volume -= increment
	glory.sfx_volume  = clamp(glory.sfx_volume, -20,0)
	glory.sfx_volume_changed.emit(glory.sfx_volume)

static func add_sfx_volume(node:Node, increment:int):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")
	glory.sfx_volume  += increment
	glory.sfx_volume  = clamp(glory.sfx_volume, -20,0)
	glory.sfx_volume_changed.emit(glory.sfx_volume)	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
