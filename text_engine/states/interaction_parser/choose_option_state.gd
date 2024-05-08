extends EmptyState
class_name ChooseOptionState
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
#Choose and load interaction are different because there could be "in" and "out" states.
#Args that get passed in through the state machine
var _args 
var _reference #usually 'self'
var state_machine #state machine attached to the reference passed in
var title_node
var content_node
var options_node
var portrait_node_0
var portrait_node_1
var a #alpha, for fading
var t# For handling animations

	
func determineOptionIndex(interaction_id):
	var index = 0
	for option in _reference.active_interaction.options:
		if option.links_to == interaction_id:
			return index
		else:
			index += 1		
			
	#push_error("No matching option index found")

func stateEnter(args):
	a = 1.0
	t = 0.0
	_args = args
	title_node = _reference.get_node("interaction_fg/text_title")
	content_node = _reference.get_node("interaction_fg/text_content")
	options_node = _reference.get_node("interaction_fg/options_organizer")
	#Does finding nodes not work if the nodes aren't visible? Getting an odd, seemingly unserious error about it.
	portrait_node_0 = _reference.get_node("interaction_fg/portrait_controller/portrait_0")
	portrait_node_1 = _reference.get_node("interaction_fg/portrait_controller/portrait_1")
	
func stateUpdate(dt):
	t += dt
	_reference.selected_word = null
	var index = determineOptionIndex(_args)
	#fade out
	"""
	if !(is_equal_approx(a, 0.0)):
		a = lerp(a, 0.0, .2) #TODO: Add smoothstep
		title_node.modulate.a = a
		content_node.modulate.a = a
		options_node.modulate.a = a
		portrait_node_0.modulate.a = a
		portrait_node_0.modulate.a =a
		return

	"""
	title_node.modulate = title_node.modulate.lerp(Color(1.0,1.0,1.0,0.0), t)
	content_node.modulate = content_node.modulate.lerp(Color(1.0,1.0,1.0,0.0), t)
	options_node.modulate = options_node.modulate.lerp(Color(1.0,1.0,1.0,0.0), t)
	portrait_node_0.modulate = portrait_node_0.modulate.lerp(Color(1.0,1.0,1.0,0.0), t)
	
	if t < .15:
		return
	#need to wait for complete...
	if !_reference.active_interaction.options[index].has("functions"):
		var interaction_to_load = TextTools.getInteractionResource(_args)
		#load option is used to fade in/out

		_reference.state_machine.Change("load_option", interaction_to_load)
		#push_error("No functions found on this option")
	if _reference.active_interaction.options[index].has("functions"):
		var funcs_to_execute = _reference.active_interaction.options[index].functions
		TextTools.executeFunctions(_reference, funcs_to_execute)

		var interaction_to_load = TextTools.getInteractionResource(_args)
		#I believe, though am not certain, that a redirect function would work
		#Since it comes before this load option
		#load option is used to fade in/out
		
		#Save the current game state to the_glory.the_memory
		
		_reference.state_machine.Change("load_option", interaction_to_load)
	
	#If text is done updating, we should do state_machine.Change("finished")

func _init(reference, args=null): #usually self, {args}
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
