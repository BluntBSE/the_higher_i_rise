extends EmptyState
class_name StartMenuHoverState


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
var _reference: SlotButton#usually 'self'
var state_machine #state machine attached to the reference passed in



func stateEnter(args):
	_args = args
	var rtl:RichTextLabel = _reference.find_child("slot_text")
	var hover_hex = Principles.lantern.color
	var hover_color = Color(hover_hex)
	rtl.add_theme_color_override("default_color", hover_color)

func stateUpdate(_dt):
	if Input.is_action_just_pressed("left_click"):
		if _reference.start_or_load == "start":
			MMFunctions.start_game(_reference, _reference.slot_number)
			return
		if _reference.start_or_load == "load":
			MMFunctions.load_game(_reference, _reference.save_file)
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
