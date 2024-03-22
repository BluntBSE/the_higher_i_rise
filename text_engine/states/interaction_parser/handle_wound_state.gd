extends EmptyState
class_name HandleWoundState
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
var memory_panel

func determine_wound_number(word_id:String, wound_dict:Dictionary):
	for wound in wound_dict:
		if wound_dict[wound].word_id == word_id:
			print("Wound slot determined to be " + wound)
			return str(wound)
		else:
			print("Could not find wound's word ID in the wound list")
			return null
	
	

func stateEnter(args):
	
	_args = args
	memory_panel = _reference.get_node("side_panel/memory_panel")
func stateUpdate(dt):
	#TODO: If the player already has a word, consider making it impossible to take it
	#Add the wound_id to the aspects_panel mem_inventory
	memory_panel.mem_inventory.push_back(_args)
	
	#Either trigger a state update on the side panel, or directly update the aspects
	#In the aspect panel
	memory_panel.state_machine.Change("refresh", null)
	
	#Last, transition to wherever the wound_link points to.
	#If text is done updating, we should do state_machine.Change("finished")
	var wound_slot = determine_wound_number(_args, _reference.active_interaction.wounds)

	var next_interaction_id = _reference.active_interaction.wounds[wound_slot].wound_link
	var next_interaction = TextTools.getInteractionResource(next_interaction_id)
	state_machine.Change("load_interaction", next_interaction)
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
