extends EmptyState
class_name SwapWordState
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

func getSlotKey(word):
	var slots = _reference.active_interaction.slots
	for slot in slots:
		if slots[slot] == word:
			return str(slot)
	return null
	


func parseInteraction(interaction: Interaction):
	
	var output_node = _reference.get_node('text_content')
	var interaction_text = interaction.text
	output_node.Text = interaction_text
	
	

func stateEnter(args):
	print("Entering swap word state")
	_args = args


func stateUpdate(dt):
	#Save the word id in _args to a variable in the _self reference, "selected_word"
	var first_word = _reference.selected_word
	var first_slot = _reference.selected_slot
	var second_word = _args
	var second_slot = getSlotKey(_args)
	var interaction = _reference.active_interaction #Clone??? Reference in memory might not be enough. Consider .New()
	interaction.slots[first_slot] = second_word
	interaction.slots[second_slot] = first_word
	var interaction_text = interaction.text
	var open_tags = TextEffects.selected.open
	var close_tags = TextEffects.selected.close
	var replaced_str = interaction_text.replace(open_tags, '')
	replaced_str = replaced_str.replace(close_tags,'')
	#Remove anything left by hover, too.
	var open_hover = TextEffects.hover.open
	var close_hover = TextEffects.hover.close
	replaced_str = replaced_str.replace(open_hover, '')
	replaced_str = replaced_str.replace(close_hover,'')
	interaction.text = replaced_str
	_reference.active_interaction = interaction
	_reference.hovered_slot = null
	
	
	_reference.selected_word = null	
	_reference.selected_slot = null
	

	#Do any styling here
	_reference.state_machine.Change("load_interaction", interaction)
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
