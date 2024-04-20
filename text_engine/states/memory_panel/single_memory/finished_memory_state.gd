extends EmptyState
class_name FinishedMemoryState
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
	_reference.get_node("pulse_shader_rect").visible = false
	_reference.scale = Vector2(1.0,1.0)
	_args = args

func stateUpdate(_dt):

	if _reference.is_hovered == true:
		_reference.state_machine.Change("hovered", null)
		
	
func stateExit():
	pass
	
	#If text is done updating, we should do state_machine.Change("finished")
	
func stateHandleInput():
	pass

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
