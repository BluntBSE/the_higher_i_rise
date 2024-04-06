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
	print("Entered memory refresh")
	_args = args

func stateUpdate(dt):
	#Delete all children (rendered words), as we are refreshing the list.
	var organizer = _reference.get_node("card_organizer")
	var children = organizer.get_children()
	for child in children:
		child.queue_free()
	var memories = _reference.mem_inventory
	var index = 0
	var offset = 50
	for memory in memories:
		var calc_offset = (index * offset)
		#spawn_memory_card(offset)
		#assign spawned card to panel
		var child_node = load("res://text_engine/packed_scenes/word_card.tscn").instantiate()
		child_node.unpack(memory)
	
		organizer.add_child(child_node) 
		child_node.position=Vector2(0,0)
		child_node.position = child_node.position + Vector2(0, calc_offset)
		#Subscribe parser to child signals
		var root:Node = child_node.get_tree().get_root()
		print(root)
		print(root.get_tree_string_pretty())
		var parser = root.get_node("main/interaction_parser") #TODO: Eventually, interaction_parser won't be the root and we have to change this.
		var callback = parser._on_select_memory
		child_node.memory_selected.connect(callback)
		#Positioning
		#Increment index
		index += 1

	#Choosing not to refresh constantly, but perhaps we could.
	_reference.state_machine.Change("finished", null)	

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
