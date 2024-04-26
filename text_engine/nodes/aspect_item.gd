extends HBoxContainer
class_name SingleAspect
var aspect_id
var texture_node 
var value_node
var state_machine: StateMachine2 = StateMachine2.new()

func unpack(aspect_name, value = null):
	var resource_path = TextTools.getResourceFromDirectory('res://content/catalogs/aspects/', aspect_name)
	var resource = load(resource_path)
	var texture_path = resource.icon
	texture_node = find_child("texture_node")
	value_node = find_child("value_node")
	texture_node.texture = load(texture_path)
	tooltip_text = resource.display_name
	if value != null:
		value_node.text = str(value)
	aspect_id = resource.aspect_id
	pass

#State machines might need to go into ready and not init, but let's try it.
func _init():
	#state_machine.Add("emphasize", EmphasizeAspectState.new(self, "arg_to_emphasize_init")
	#state_machine.Add("finished", FinishedTextState.new(self, "arg_to_finished_init"))
	pass

	
func _ready():
	#texture_node = find_child("texture_node")
	#value_node = find_child("value_node")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
