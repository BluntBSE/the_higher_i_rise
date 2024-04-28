extends ColorRect
class_name UIButton

var state_machine = StateMachine2.new()
@export var text:String
@export var exec_class:String #Name of the class to search for the function in execute.
@export var execute:String

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("button_text").text = text
	state_machine.Add("hover_state", UIHoverButtonState.new(self, "init hover args"))
	state_machine.Add("normal", UINormalButtonState.new(self, "init normal MM button args"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	pass


func _on_mouse_entered():
	state_machine.Change("hover_state", null)
	pass # Replace with function body.


func _on_mouse_exited():
	state_machine.Change("normal", null)
	pass # Replace with function body.
