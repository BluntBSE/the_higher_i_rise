@tool
extends ColorRect
class_name BigUIButton


var state_machine = StateMachine2.new()
@export var text:String
@export var exec_class:String #Name of the class to search for the function in execute.
@export var execute:String
@export var text_node:RichTextLabel
@export var args:Array


@export var is_engine_configured = false

func _init():
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("button_text").text = text
	state_machine.Add("hover_state", UIHoverButtonState.new(self, "init hover args"))
	state_machine.Add("normal", UINormalButtonState.new(self, "init normal MM button args"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Just to make UI visible in editor
	if Engine.is_editor_hint():
		#if is_engine_configured == false:
		text_node.text =  text
	
	
	else:
		state_machine.stateUpdate(delta)



func _on_mouse_entered():
	state_machine.Change("hover_state", args)
	pass # Replace with function body.


func _on_mouse_exited():
	state_machine.Change("normal", null)
	pass # Replace with function body.
