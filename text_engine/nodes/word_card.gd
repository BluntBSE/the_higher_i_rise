extends VBoxContainer
class_name Memory

var base_color = '#9b737f'
var header_color = "#9b737f"
var highlight_color = '#ebdb87'
var is_hovered = false
var state_machine = StateMachine2.new()
var word_id = null
var random_variable = "foo_baby"
signal memory_selected
func determine_prefix(_word_id):
	var word_to_load = TextTools.getWordResource(_word_id)
	var part_speech = word_to_load.part_speech #noun, verb, adjective
	var map = {
		"noun": "n.",
		"adjective": "adj.",
		"verb": "v."
	}
	return map[part_speech]
#Essentially the constructor function we'll use when loading this as a packed scene.
func unpack(_word_id):
	self.word_id = _word_id #For ease of access later.
	var title_node = find_child("word_title")
	var description_node = find_child("word_description")
	var aspects_node = find_child("word_aspects")
	var principles_container = find_child("principles_container")
	var word_to_load = TextTools.getWordResource(_word_id)
	var greatest_principle = TextTools.determineGreatestPrinciple(word_to_load.principles)
	#Clear the default principle_boxes in this node.
	for child in principles_container.get_children():
		child.queue_free()
	base_color = Principles[greatest_principle].color
	var title_text = word_to_load.text.capitalize()
	var prefix = determine_prefix(_word_id)
	title_text = prefix + " " + title_text
	title_text = "[i]" + title_text + "[/i]"
	title_node.text = title_text
	description_node.text = "[i]"+word_to_load.description+"[/i]"
	var aspects_str = word_to_load.part_speech + ", " 
	var aspect_index = 0 #for tracking if we should add a comma to the last one
	for aspect in word_to_load.aspects:
		if aspect_index < word_to_load.aspects.size()-1:
			aspects_str += (aspect +", ")
		else:
			aspects_str += aspect
	aspects_node.text = aspects_str
	
	
	var sorted_principles = TextTools.sortPrinciples(word_to_load.principles)
	for principle in sorted_principles:
		var principle_box = load("res://text_engine/packed_scenes/principle_box.tscn").instantiate()
		principle_box.unpack(principle, word_to_load.principles[principle])#("Moth", 2)
		principles_container.add_child(principle_box)
		


func _init():
	pass
	#color = base_color
	state_machine.Add("finished", FinishedMemoryState.new(self, "init finished memory state"))
	state_machine.Add("hovered", HoveredMemoryState.new(self, "init hovered memory state"))
	state_machine.Add("selected", SelectedMemoryState.new(self, "init selected memory state"))
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	state_machine.Change("finished", null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	pass


func _on_mouse_entered():
	is_hovered = true
	
	#When click, replace with a "selected" state
	



func _on_mouse_exited():
	is_hovered = false
	#Replace with a real regular state
	
	


