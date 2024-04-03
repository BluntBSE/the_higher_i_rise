extends EmptyState
class_name SwapMemoryState
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
	
	var output_node = _reference.get_node('interaction_fg/text_content')
	var interaction_text = interaction.text
	output_node.Text = interaction_text
	
	

func stateEnter(args):
	_args = args


func stateUpdate(dt):
	var memory_panel = _reference.get_node('side_panel/memory_panel')
	#Save the word id in _args to a variable in the _self reference, "selected_word"
	var word_in_parser = _args[0]
	var word_in_memory = _args[1]
	var parser_slot = getSlotKey(word_in_parser)
	var memory_index = memory_panel.mem_inventory.find(word_in_memory)
	var interaction = _reference.active_interaction
	interaction.slots[parser_slot] = word_in_memory
	memory_panel.mem_inventory.erase(word_in_memory)
	memory_panel.mem_inventory.insert(memory_index, word_in_parser)
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
	_reference.selected_memory=null
	

	#Do any styling here
	_reference.state_machine.Change("load_interaction", interaction)
	memory_panel.state_machine.Change("refresh", null)
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
