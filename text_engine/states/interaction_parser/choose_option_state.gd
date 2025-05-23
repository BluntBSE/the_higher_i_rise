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

func record_history(interaction_resource:Interaction, interaction_key):
		var recorded_at = Time.get_datetime_string_from_system()
		var interaction_name = _args #This is the "meta" that is passed in from click
		var aspect_dict = _reference.find_child("aspects_panel", true, false).aspect_dict
		var mem_array = _reference.find_child("memory_panel", true, false).mem_array
		var the_history = _reference.get_tree().root.get_node("the_glory").the_history
		var display_title = interaction_resource.display_title
		_reference.get_tree().root.get_node("the_glory").pages += 1
		#print("Glory pages", _reference.get_tree().root.get_node("the_glory").pages)
		the_history.append ( {"aspect_dict": aspect_dict, "mem_array": mem_array, "pages_at_recording": _reference.get_tree().root.get_node("the_glory").pages, "recorded_at": recorded_at, "display_title": display_title, "interaction_key": interaction_key } )
		print("History")
		print(the_history)
	

func determineOptionIndex(interaction_id):
	var index = 0
	for option in _reference.active_interaction.options:
		#CAREFUL WITH YOUR DUMMY INTERACTION IDS HERE
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
	print("Options are", _reference.active_interaction.options)
	if !_reference.active_interaction.options[index].has("functions"):
		print("No functions in:", _reference.active_interaction.options[index])
		var interaction_to_load = TextTools.getInteractionResource(_args)
		#load option is used to fade in/out
		record_history(interaction_to_load, _args)
		_reference.state_machine.Change("load_option", interaction_to_load)
		#push_error("No functions found on this option")
	if _reference.active_interaction.options[index].has("functions"):

		var funcs_to_execute = _reference.active_interaction.options[index].functions
		print("Functions found")
		print(funcs_to_execute)		
		TextTools.executeFunctions(_reference, funcs_to_execute)

		var interaction_to_load = TextTools.getInteractionResource(_args)
		#I believe, though am not certain, that a redirect function would work
		#Since it comes before this load option
		#load option is used to fade in/out
		
		#Save the current game state to the_glory.the_memory
		record_history(interaction_to_load, _args)
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
