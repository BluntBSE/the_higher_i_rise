extends Node
class_name MMFunctions

static func start_game(node:Node):
	var root = node.get_tree().root

	root.get_node("main_menu").visible = false
	root.add_child(load("res://game_scenes/main.tscn").instantiate())
	#Deleting the main menu from the tree before the new thing is instanced
	#Can cause a crash.
	root.get_node("main_menu").free()

static func load_game(node:Node, slot:String):#Needs arg for save slot
	var filename = "single_user.tres"#TODO: This to be replaced by slot
	#var save_path = "user://"+filename
	var save_path = "user://"+slot
	var loaded_file = ResourceLoader.load(save_path)

	var root = node.get_tree().root
	root.get_node("main_menu").visible = false
	
	#Do some graphics here to cover the little glitchy load-in.
	
	var main = load("res://game_scenes/main.tscn").instantiate()
	root.add_child(main)
	main.visible = false
	
	var parser:InteractionParser = root.get_node("main/interaction_parser")
	var aspect_panel:AspectPanel = root.find_child("aspects_panel", true, false)
	var memory_panel:MemoryPanel = root.find_child("memory_panel", true, false)
	
	parser.state_machine.Change("load_interaction", loaded_file.active_interaction)
	aspect_panel.aspect_dict = loaded_file.aspects
	memory_panel.mem_inventory = loaded_file.words
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
