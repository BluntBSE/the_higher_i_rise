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

func executeFunctions(functions:Array):
	#Functions arrive in the form of: [ ["function_id", [arg_1, arg_2_, arg_3], ["function_id_2", [args...] ]
	for function_pair in functions:
		var function_id = function_pair[0]
		var function_args = function_pair[1]
		var _engine_functions = EngineFunctions.new() 
		#I must make the _engine_functions node a child of the _reference (interaction parser)
		_reference.add_child(_engine_functions)
		if !(function_id in _engine_functions):
			print("Engine functions does not have function: " + function_id)
			_engine_functions.queue_free()
		else:
		#You cannot use .callv() on a static class, so must make an instance.
			_engine_functions.callv(function_id, function_args)
			#Do I need to delete that _engine_functions? Queue_free does that. Might as well.
			_engine_functions.queue_free()
	

	
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
	portrait_node_0 = _reference.get_node("interaction_fg/portrait_controller/portrait_0")
	portrait_node_1 = _reference.get_node("Interaction_fg/portrait_controller/portrait_1")
	
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
		push_error("No functions found on this option")
	if _reference.active_interaction.options[index].has("functions"):
		var funcs_to_execute = _reference.active_interaction.options[index].functions
		executeFunctions(funcs_to_execute)
		var interaction_to_load = TextTools.getInteractionResource(_args)
		#load option is used to fade in/out
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
