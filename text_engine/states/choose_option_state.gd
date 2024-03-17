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
	pass

	
func determineOptionIndex(interaction_id):
	print("Interaction ID arg is:: " + interaction_id)
	var index = 0
	for option in _reference.active_interaction.options:
		print("Option link")
		print(option.links_to)
		if option.links_to == interaction_id:
			return index
			index += 1		
	print("No matching option index found")

func stateEnter(args):
	
	_args = args

func stateUpdate(dt):
	var index = determineOptionIndex(_args)
	if !_reference.active_interaction.options[index].has("functions"):
		print("No functions found on this option")
	if _reference.active_interaction.options[index].has("functions"):
		var funcs_to_execute = _reference.active_interaction.options[index].functions
		executeFunctions(funcs_to_execute)
		var interaction_to_load = TextTools.getInteractionResource(_args)
		_reference.state_machine.Change("load_interaction", interaction_to_load)
	
	#If text is done updating, we should do state_machine.Change("finished")

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
