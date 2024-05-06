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
var t:float  #Set at 0 when we enter this state, incremented by DT to determine lerp.
var start_pos:Vector2 #Noted when the state is entered. Used in animations
var scale_factor:float = 1.2 #Used to calculate end position.
var scaled_position:Vector2 = Vector2()

func stateEnter(args):
	t = 0.0
	start_pos = _reference.position
	root = _reference.get_tree().get_root()
	print(root)
	parser = root.get_node('the_glory/main/interaction_parser')
	_args = args
	#_reference.memory_selected.emit(_reference)	
	_reference.z_index += 10


func stateUpdate(dt):
	t += dt*.8
	var target_scale = Vector2(1.20,1.20)
	_reference.scale = _reference.scale.lerp(target_scale, t)
	var target_pos = start_pos + Vector2(-100,0)
	_reference.position = _reference.position.lerp(target_pos, t)
	
	
	if Input.is_action_just_released("left_click"):
		
		if parser.selected_word == null:
			_reference.state_machine.Change("selected", {"start_pos":start_pos, "hover_pos": target_pos, "hover_scale": target_scale})
		else:
			var args = [parser.selected_word, _reference.word_id]
			parser.state_machine.Change("swap_memory", args)
	
	if _reference.is_hovered == false:
		_reference.state_machine.Change("finished", null)

	
func stateExit():
	_reference.position = start_pos


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
