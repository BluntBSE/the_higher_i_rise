extends EmptyState
class_name HoveredMemoryState

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
var root # For finding and identifying the parser
var parser


func stateEnter(args):
	root = _reference.get_tree().get_root()
	parser = root.get_node('interaction_parser')
	_reference.color = _reference.highlight_color
	_args = args
	_reference.memory_selected.emit(_reference)	


func stateUpdate(dt):
	
		if Input.is_action_just_released("left_click"):
			if parser.selected_word == null:
				_reference.state_machine.Change("selected", null)
			else:
				var args = [parser.selected_word, _reference.word_id]
				parser.state_machine.Change("swap_memory", args)
		
		if _reference.is_hovered == false:
			_reference.state_machine.Change("finished", null)
	
	
func stateExit():
	pass
	
	#If text is done updating, we should do state_machine.Change("finished")
	
func stateHandleInput():
	print("Handling input from hovered memory state")
	

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
