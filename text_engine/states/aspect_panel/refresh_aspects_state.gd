extends EmptyState
class_name RefreshAspectsState

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
var _reference:AspectPanel #usually 'self'
var state_machine #state machine attached to the reference passed in


func stateEnter(args):
	_args = args

func stateUpdate(_dt):
	#Clear existing aspect icons
	var grid = _reference.get_node("aspect_grid")
	for child in grid.get_children():
		child.queue_free()
	var aspects = _reference.aspect_dict
	for aspect in aspects:
		var single_aspect = load("res://text_engine/packed_scenes/aspect_item.tscn").instantiate()
		single_aspect.unpack(aspect, aspects[aspect])
		grid.add_child(single_aspect)

	state_machine.Change("finished", null)
	
	
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