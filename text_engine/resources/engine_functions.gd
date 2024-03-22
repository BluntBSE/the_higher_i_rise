extends Node
class_name EngineFunctions



func print_string(string:String):
	print("Firing print_string")
	print(string)

func remove_memory(word_id:String):
	var current_tree = get_tree()
	var current_parent = get_parent()
	var memory_panel = current_parent.get_node("side_panel/memory_panel")
	memory_panel.mem_inventory.erase(word_id)
	memory_panel.state_machine.Change("refresh", null)
	return null
