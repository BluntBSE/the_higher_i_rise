extends EmptyState
class_name HistoryMenuOpenState



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
	#Darkens the screen, blocks input
	_reference.get_node("pause_filter").visible = true
	_reference.get_node("pause_filter/history_menu").visible = true
	var glory  = _reference.get_tree().root.get_node("the_glory")
	_reference.get_node("pause_filter/history_menu").unpack()
	_reference.get_node("pause_filter/history_menu/history_rect").unpack(glory.the_history)
	pass

func stateUpdate(_dt):
	if Input.is_action_just_released("ui_cancel"):
		_reference.state_machine.Change("playing", null)
	pass
	
	
func stateExit():
	_reference.get_node("pause_filter").visible = false
	_reference.get_node("pause_filter/history_menu").visible = false
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
