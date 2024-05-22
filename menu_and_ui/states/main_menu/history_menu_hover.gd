extends EmptyState
class_name HistoryMenuHoverState


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
var _reference#usually 'self'
var state_machine #state machine attached to the reference passed in



func stateEnter(args):
	_args = args
	var rtl:RichTextLabel = _reference.find_child("interaction_name")
	var hover_hex = Principles.lantern.color
	var hover_color = Color(hover_hex)
	rtl.add_theme_color_override("default_color", hover_color)

func stateUpdate(_dt):
	if Input.is_action_just_pressed("left_click"):
			var glory = _reference.get_tree().root.get_node("the_glory")
			MMFunctions.remember_game(glory, _reference._history_item, _reference._history_key)
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
