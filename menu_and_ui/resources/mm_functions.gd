extends Node
class_name MMFunctions

#These menus are starting to look like they should all be a shared class...Let's see if we make more than start + opts

static func start_game_menu(node: Node):

	var root = node.get_tree().root
	var filter = root.find_child("mm_screen_filter", true, false)
	filter.visible = true
	var s_game_menu = root.find_child("start_game_menu", true, false)
	s_game_menu.visible=true
	s_game_menu.unpack()
	
static func open_opts_menu(node:Node):
	var root = node.get_tree().root
	var filter = root.find_child("mm_screen_filter", true, false)
	filter.visible = true
	var opts_menu = root.find_child("options_menu", true, false)
	opts_menu.visible=true
	#opts_menu.unpack()
	
static func cancel_start(node: Node):
	var root = node.get_tree().root
	var filter = root.find_child("mm_screen_filter", true, false)
	var start_menu = root.find_child("start_game_menu", true, false)
	start_menu.visible=false;
	filter.visible = false	

static func cancel_opts(node: Node):
	var root = node.get_tree().root
	var filter = root.find_child("mm_screen_filter", true, false)
	var opts_menu = root.find_child("options_menu", true, false)
	opts_menu.visible = false
	filter.visible = false	
	

static func start_game(node:Node, slot_number):
	var glory:TheGlory = node.get_tree().root.get_node("the_glory")

	glory.get_node("main_menu").visible = false
	var main_scene = load("res://game_scenes/main.tscn").instantiate()
	main_scene.active_save = slot_number
	glory.add_child(main_scene)
	
	
	#Deleting the main menu from the tree before the new thing is instanced
	#Can cause a crash.
	glory.get_node("main_menu").free()


static func load_game(node:Node, save:SaveFile, slot_number:int):#Needs arg for save slot

	
	var root = node.get_tree().root
	root = root.get_node("the_glory")
	root.print_tree_pretty()
	root.get_node("main_menu").visible = false
	
	#Do some graphics here to cover the little glitchy load-in.
	
	var main = load("res://game_scenes/main.tscn").instantiate()
	main.active_save = slot_number
	root.add_child(main)
	main.visible = false
	
	var parser:InteractionParser = root.get_node("main/interaction_parser")
	var aspect_panel:AspectPanel = root.find_child("aspects_panel", true, false)
	var memory_panel:MemoryPanel = root.find_child("memory_panel", true, false)
	parser.state_machine.Change("load_interaction", save.active_interaction)
	aspect_panel.aspect_dict = save.aspects
	memory_panel.mem_inventory = save.words
	aspect_panel.state_machine.Change("refresh", null)
	memory_panel.state_machine.Change("refresh", null)
	
	main.visible=true
	
	#Deleting the main menu from the tree before the new thing is instanced
	#Can cause a crash.
	root.get_node("main_menu").free()
	
	pass

static func quit_game(node:Node):
	node.get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	node.get_tree().quit()

static func delete_slot(node:Node, slot:int):
	var key = "slot_"+str(slot)
	var file = ResourceLoader.load("user://slots.tres")
	file.saves[key] = null
	ResourceSaver.save(file, "user://slots.tres")
	node.get_tree().root.find_child("start_game_menu", true, false).unpack() #Refresh the menu
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
