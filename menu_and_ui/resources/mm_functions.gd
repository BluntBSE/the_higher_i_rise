extends Node
class_name MMFunctions

static func start_game(node:Node):
	var root = node.get_tree().root

	root.get_node("main_menu").visible = false
	root.add_child(load("res://game_scenes/main.tscn").instantiate())
	#Deleting the main menu from the tree before the new thing is instanced
	#Can cause a crash.
	root.get_node("main_menu").free()


static func quit_game(node:Node):
	node.get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	node.get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
