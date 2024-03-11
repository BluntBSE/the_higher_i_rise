extends EmptyState
class_name LoadInteractionState
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
#Args that get passed in through the state machine.  Here, an interaction.
var _args#: Interaction
var _reference#: Node2D #usually passed as 'self'
var state_machine#: LoadInteractionState #state machine attached to the reference passed in

#Variables set by the interaction
var _base_bg_color: Color = Color(1.0, 1.0, 1.0, 1.0)
var _text: String
var _slots: Dictionary = {"slot_1": "#ID69"}
var _options: Array

func parseOptions(interaction: Interaction):
	#What to do when null interaction arrives?
	if !interaction:
		print("null interaction in parseOptions")
		return null #Probably should do an EmptyInteraction class
	
	var output_node = _reference.get_node('options_content')
	var output_text = ""
	var index = 0
	if len(interaction.options) > 0:
		for option in interaction.options:
			if index > 0:
				output_text = output_text+"[p]"
			output_text += '[url="'
			output_text += option.links_to
			output_text += '"]'
			output_text += option.text
			output_text += '[/url]'
		

	output_node.text = output_text

func parseInteraction(interaction: Interaction):
	#Store
	if interaction:
		var output_node = _reference.get_node('text_content')
		var output_bg = _reference.get_node('interaction_bg')
		_base_bg_color = interaction.base_bg_color
		_text = interaction.text
		_slots = interaction.slots
		_options = interaction.options
		
		#Apply - This may be moved to its own state at some point.
		var output_text = TextTools.parseText(_text, interaction)
		output_node.text = output_text
		#output_node.append_text(output_text) #Append is recommended for rapid drawing, but not appropriate here.
		output_bg.color = _base_bg_color
		_reference.active_interaction = interaction #this may or may not be redundant. I think it might be useful if we can recycle this to use modified interactions from choose_option, which is why I've done it.
		
		

func stateEnter(args: Interaction):
	_args = args

func stateUpdate(dt):
	parseInteraction(_args)
	parseOptions(_args)
	_reference.state_machine.Change("finished", null) #No arguments required for the  "finished" state, I think

	pass
	#If text is done updating, we should do state_machine.Change("finished")

func _init(reference, args): #usually self, {args}. Here, an interaction
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
