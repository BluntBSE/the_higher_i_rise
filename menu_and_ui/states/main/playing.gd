extends EmptyState
class_name PlayingGameState


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
var _reference:Control #usually 'self'
var state_machine #state machine attached to the reference passed in


func stateEnter(args):
	_reference.get_node("pause_filter").visible = false
	#Stop input from happening on the parser
	#Maybe darken the screen a bit
	#pause_filter.mouse_filter = Stop?
	#Instantiate the menu
	pass

func stateUpdate(_dt):
	if Input.is_action_just_released("ui_cancel"):
		print("Detected escape key")
		_reference.state_machine.Change("menu_open", null)

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
