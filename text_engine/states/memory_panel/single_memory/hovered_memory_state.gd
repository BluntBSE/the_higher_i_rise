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


func stateEnter(args):
	_reference.color = _reference.highlight_color
	_args = args
#TODO: Register the interaction parser with this memory so we can emit signals to it

func stateUpdate(dt):
		#TODO: emit a signal to the interaction parser allowing it to be aware of the word swap.
		if Input.is_action_just_released("left_click"):
			_reference.state_machine.Change("selected", null)
		
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
