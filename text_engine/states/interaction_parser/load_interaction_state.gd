extends EmptyState
class_name LoadInteractionState


##This generic loadinteractionstate is used for ALL instances of an interaction loading
##Including hovers, swaps, etc. It is NOT to be used for switching as a consequence of an option

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
var _title: String




func parseInteraction(interaction: Interaction):
	#Store
	if interaction:
		var output_title = _reference.get_node("interaction_fg/text_title")
		var output_node = _reference.get_node('interaction_fg/text_content')
		var output_bg = _reference.get_node('interaction_bg')
		#This whole setting process might be better suited by returning a new interaction constructed
		#If we even want to do any processing. Currently, in the play area, this only sets the text, color, etc.
		#These internal _variables don't seem to be accessed
		_base_bg_color = interaction.base_bg_color
		_text = interaction.text
		_slots = interaction.slots
		_options = interaction.options
		_title = interaction.display_title
		

		
		#Apply - This may be moved to its own state at some point.
		var output_text = TextTools.parseText(_text, interaction)
		output_node.text = output_text
		output_title.text = "[u][b]"+_title+"[/b][/u]"
		#output_node.append_text(output_text) #Append is recommended for rapid drawing, but not appropriate here.
		output_bg.color = _base_bg_color
		_reference.active_interaction = interaction #this may or may not be redundant. I think it might be useful if we can recycle this to use modified interactions from choose_option, which is why I've done it.
		
		

func stateEnter(args: Interaction):
	_args = args
	
func stateExit():

	

		#Switch state/return
	return null

func stateUpdate(_dt):
	#TODO: Somehow need to clear any selected words, etc.
	ImgTools.parsePortraits(_reference, _args)
	parseInteraction(_args)
	TextTools.parseOptions(_reference, _args)	
	_reference.state_machine.Change("finished", null)
	
	#If text is done updating, we should do state_machine.Change("finished")

func _init(reference, args): #usually self, {args}. Here, an interaction
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
