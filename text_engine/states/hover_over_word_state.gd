extends EmptyState
class_name HoverWordContentState
'''
class_name EmptyState

	func stateUpdate(dt):
		pass
	func stateHandleInput():
		pass
	func stateEnter(args):
		pass
	func stateExit():
		pass
		
'''
#Args that get passed in through the state machine
var _args 
var _reference #usually 'self'
var state_machine #state machine attached to the reference passed in

func applyHover(word: IWord, reference): #'Reference' is a reference to interaction_parser, or a similar component that tracks whether it's got hover on it

	var text = ""
	#Check if this word is currently hovered. If it is...
 
	
	#Check if this word is currently selected. If it is...
	
	

	text += "[url=" + word.id + "]"
	
		

		
	return text


func getSlotKey(word):
	var slots = _reference.active_interaction.slots
	for slot in slots:
		if slots[slot] == word:
			return str(slot)
		else:
			print("No slot found for: " + str(word))
	


func parseInteraction(interaction: Interaction):
	
	var output_node = _reference.get_node('text_content')
	print(output_node)
	var interaction_text = interaction.text
	output_node.Text = interaction_text
	
	

func stateEnter(args):
	print("Entering select word content state")
	_args = args
	print(_args)

func stateUpdate(dt):
	#Save the word id in _args to a variable in the _self reference, "selected_word"
	print("Hello from selection update")
	print(_args)
	_reference.selected_word = _args
	_reference.selected_slot = getSlotKey(_args)
	print("Found " + _args + "in slot: " + getSlotKey(_args) )
	#Do any styling here
	_reference.state_machine.Change("finished", null)
	#Determine what slot in the current interaction contains the word id
	#save that to a selected_slot in the _self reference?
	return null

func _init(reference, args=null): #usually self, {args}
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
