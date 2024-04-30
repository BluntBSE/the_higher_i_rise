extends EmptyState
class_name StartMenuNormalState


'''
class_name EmptyState

	func stateUpdate(dt):
	func stateHandleInput():
		pass
		pass
	func stateEnter(args):
		pass
	func stateExit():
		pass
		
'''
#Args that get passed in through the state machine
var _args 
var _reference: SlotButton#usually 'self'
var state_machine #state machine attached to the reference passed in



func stateEnter(args):
	_args = args
	var rtl:RichTextLabel = _reference.find_child("slot_text")
	rtl.add_theme_color_override("default_color", Color.WHITE)

func stateUpdate(_dt):

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
