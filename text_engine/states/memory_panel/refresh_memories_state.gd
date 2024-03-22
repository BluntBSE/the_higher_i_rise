extends EmptyState
class_name RefreshMemoriesState

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
	print("Entered refresh state")
	_args = args

func stateUpdate(dt):
	#Delete all children (rendered words), as we are refreshing the list.
	var children = _reference.get_children()
	for child in children:
		child.queue_free()
	var memories = _reference.mem_inventory
	var index = 0
	var offset = 100
	for memory in memories:
		var calc_offset = (index * offset)
		print(memory)
		#spawn_memory_card(offset)
		#assign spawned card to panel
		var child_node = load("res://text_engine/packed_scenes/memory_bg.tscn").instantiate()
		child_node.unpack(memory)
		_reference.add_child(child_node)
		child_node.global_position = child_node.global_position + Vector2(0, calc_offset)
		index += 1

	#Choosing not to refresh constantly, but perhaps we could.
	_reference.state_machine.Change("finished", null)
	#If text is done updating, we should do state_machine.Change("finished")

func _init(reference, args=null): #usually self, {args}
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
