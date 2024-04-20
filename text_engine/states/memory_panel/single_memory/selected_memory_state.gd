extends EmptyState
class_name SelectedMemoryState
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
var hover_pos
var start_pos
var hover_scale


func stateEnter(args):
	_args = args
	hover_pos = _args.hover_pos
	start_pos = _args.start_pos
	hover_scale = _args.hover_scale
	_reference.memory_selected.emit(_reference)
	_reference.position = hover_pos
	_reference.get_node("pulse_shader_rect").visible = true


func stateUpdate(_dt):
	
	
	if Input.is_action_just_released("left_click"):
		_reference.state_machine.Change("finished", null)
	
func stateExit():
	_reference.position = start_pos
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
func _process(_delta):
	pass
