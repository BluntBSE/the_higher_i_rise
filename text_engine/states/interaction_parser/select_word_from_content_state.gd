extends EmptyState
class_name SelectWordFromContentState
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


func parseInteraction(interaction: Interaction):
	
	var output_node = _reference.get_node('interaction_fg/text_content')
	var interaction_text = interaction.text
	output_node.Text = interaction_text
	
	

func stateEnter(args):
	_args = args

func stateUpdate(dt):
	#Save the word id in _args to a variable in the _self reference, "selected_word"
	_reference.selected_word = _args
	var slot_key = TextTools.getSlotKey(_args, _reference)
	_reference.selected_slot = slot_key
	#Do any styling here
	var interaction = _reference.active_interaction
	var interaction_text = interaction.text
	#Have to HANDLE WOUNDS here too
	var slot_str = "[b]<" + slot_key + "/>[/b]" #Match the style tags from the highlight function
	var selected_str = TextEffects.selected.open + "<" + slot_key + "/>" + TextEffects.selected.close
	var replaced_text = interaction_text.replace(slot_str, selected_str)
	interaction.text = replaced_text
	
	_reference.hovered_slot = null
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
