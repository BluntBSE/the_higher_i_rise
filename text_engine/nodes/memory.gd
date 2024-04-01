extends ColorRect
#class_name Memory

var base_color = '#9b737f'
var highlight_color = '#ebdb87'
var is_hovered = false
var state_machine = StateMachine2.new()
var word_id = null
var random_variable = "foo_baby"
signal memory_selected

#Essentially the constructor function we'll use when loading this as a packed scene.
func unpack(_word_id):
	self.word_id = _word_id #For ease of access later.
	var text_node = find_child("word_text")
	var word_to_load = TextTools.getWordResource(_word_id)
	var greatest_principle = TextTools.determineGreatestPrinciple(word_to_load.principles)
	base_color = Principles[greatest_principle].color
	text_node.text = word_to_load.text


func _init():
	color = base_color
	state_machine.Add("finished", FinishedMemoryState.new(self, "init finished memory state"))
	state_machine.Add("hovered", HoveredMemoryState.new(self, "init hovered memory state"))
	state_machine.Add("selected", SelectedMemoryState.new(self, "init selected memory state"))
# Called when the node enters the scene tree for the first time.
func _ready():
	#unpack("adj_smug") #Default word. Should be replaced.
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
	
	


