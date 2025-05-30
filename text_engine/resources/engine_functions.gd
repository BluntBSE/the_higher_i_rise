extends Node
class_name EngineFunctions


func print_string(string):
	print(string)
	
func remove_memory(word_id:String):
	#var current_tree = get_tree()
	var current_parent = get_parent()
	var memory_panel = current_parent.get_node("side_panel/memory_panel")
	memory_panel.mem_array.erase(word_id)
	memory_panel.state_machine.Change("refresh", null)
	return null
	
func set_speech(word_array:Array):
	var current_parent = get_parent()
	var memory_panel = current_parent.get_node("side_panel/memory_panel")
	memory_panel.mem_array = []
	memory_panel.mem_array = word_array.duplicate() #Assignemtn by memory thing here.
	memory_panel.state_machine.Change("refresh", null)
		
	
func update_aspects(update_dict:Dictionary):
	#var current_tree = get_tree()
	print("UPDATE ASPECTS RUNNING")
	
	var current_parent = get_parent()
	var aspects_panel:AspectPanel = current_parent.get_node("side_panel/aspects_panel")
	var aspect_dict = aspects_panel.aspect_dict
	for aspect in update_dict:
		if !aspect_dict.has(aspect):
			aspect_dict[aspect] = 0
			aspect_dict[aspect] += update_dict[aspect]
		else:
			aspect_dict[aspect] += update_dict[aspect]
	aspects_panel.state_machine.Change("refresh", null)
	
func purge_aspects(bool): #Needs SOMETHING. Can be either
	var current_parent = get_parent() #Parser
	var aspects_panel:AspectPanel = current_parent.get_node("side_panel/aspects_panel")
	aspects_panel.aspect_dict = {}
	aspects_panel.state_machine.Change("refresh", null)

func purge_speech():
	var current_parent = get_parent() #Parser
	var memory_panel:MemoryPanel = current_parent.get_node("side_panel/memory_panel")
	memory_panel.mem_array = []
	memory_panel.state_machine.Change("refresh", null)
	pass
	
