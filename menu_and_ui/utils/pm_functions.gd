extends Node
class_name PMFunctions



 
static func save_game(node:Node):
	var root = node.get_tree().root #used for accessing data in the scene
	var active_save = root.find_child("main", true, false).active_save
	var new_file = SaveFile.new()
	var active_interaction = root.find_child("interaction_parser",true, false).active_interaction
	var word_inventory = root.find_child("memory_panel", true, false).mem_array
	var aspect_inventory = root.find_child("aspects_panel", true, false).aspect_dict
	var the_history = root.get_node("the_glory").the_history
	var pages = root.get_node("the_glory").pages
	
	new_file.active_interaction = active_interaction
	new_file.words = word_inventory
	new_file.aspects = aspect_inventory
	new_file.the_history = the_history
	new_file.pages = pages
	
	#var filename = "single_user.tres" #TODO: Replace with slot
	var key = "slot_"+str(active_save)
	var slots = ResourceLoader.load("user://slots.tres")
	slots.saves[key] = new_file
	ResourceSaver.save(slots, "user://slots.tres")
	
	

	
static func return_to_main(node:Node):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")
	glory.get_node("main").queue_free()
	var main_menu = load("res://game_scenes/main_menu.tscn").instantiate()
	glory.add_child(main_menu)
	glory.music_player.play_song("air_in_time")
	
	


	
static func go_main_menu(node):
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
