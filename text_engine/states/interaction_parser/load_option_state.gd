extends EmptyState
class_name LoadOptionState

##TODO: ???##Distinct from LoadInteractionState as this has a fade_in process.
 
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

#For manipulating alpha
var title_node
var content_node
var options_node
var portrait_node_0
var portrait_node_1
var a #alpha, for fading
var t = 0.0 #Used for controlling animations
var original_color


	

				
			
func parseInteraction(interaction: Interaction):
	#Store
	if interaction:
		var output_title = _reference.get_node("interaction_fg/text_title")
		var output_node = _reference.get_node('interaction_fg/text_content')
		var output_bg = _reference.get_node('interaction_bg')
		_base_bg_color = interaction.base_bg_color
		_text = interaction.text
		_slots = interaction.slots
		_options = interaction.options
		_title = interaction.display_title
	
		#Apply - This may be moved to its own state at some point.
		var output_text = TextTools.parseText(_text, interaction)
		output_node.text = output_text
		#Optional intercept point for title manipulation, but probably not necessary.
		output_title.text = "[u][b]"+_title+"[/b][/u]"
		#output_node.append_text(output_text) #Append is recommended for rapid drawing, but not appropriate here.
		output_bg.color = _base_bg_color
		_reference.active_interaction = interaction #this may or may not be redundant. I think it might be useful if we can recycle this to use modified interactions from choose_option, which is why I've done it.
		
		

func stateEnter(args: Interaction):
	t = 0.0
	a = 0.0 #Start invisible, become visible
	_args = args
	title_node = _reference.get_node("interaction_fg/text_title")
	content_node = _reference.get_node("interaction_fg/text_content")
	options_node = _reference.get_node("interaction_fg/options_organizer")
	portrait_node_0 = _reference.get_node("interaction_fg/portrait_controller/portrait_0")
	portrait_node_1 = _reference.get_node("interaction_fg/portrait_controller/portrait_1")
	_reference.selected_word = null
	_reference.selected_slot = null
	_reference.hovered_word = null
	_reference.hovered_slot = null
	_reference.selected_memory = null
	
func stateExit():

	

		#Switch state/return
	return null


func stateUpdate(dt):
	t = t + dt
	#TODO: Somehow need to clear any selected words, etc.
	_reference.can_hover = false
	_reference.selected_word = null
	_reference.hovered_word = null
	_reference.hovered_slot = null
	ImgTools.parsePortraits(_reference, _args)
	parseInteraction(_args)
	TextTools.parseOptions(_reference, _args)
	#Fade in

	title_node.modulate = title_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	content_node.modulate = content_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	options_node.modulate = options_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	portrait_node_0.modulate = portrait_node_0.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	
	if t < .2:
		return

		
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
