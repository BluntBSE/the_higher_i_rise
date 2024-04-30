extends EmptyState
class_name IconButtonHoverState


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
var _reference:IconButton#usually 'self'
var state_machine #state machine attached to the reference passed in



func stateEnter(args):
	_args = args
	_reference.material.set("shader_parameter/replace_0", _reference.shader_hover)
	#_reference.material.shader_parameter.replace_0 = _reference.shader_hover


func stateUpdate(_dt):
	if Input.is_action_just_pressed("left_click"):
		var local_class = GlobalUtils.instantiate_class(_reference.exec_class)
		var args_to_exec = [_reference]
		if _args != null:
			for arg in _args:
				args_to_exec.append(arg)
		local_class.callv(_reference.execute, args_to_exec) #Because main menu functions often interact with the scene tree, it is helpful to pass in the node of the button as a starting point by which the tree can be traversed.
		local_class.queue_free()
	pass
	
	
func stateExit():
	pass
	
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
