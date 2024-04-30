extends TextureRect
class_name IconButton


@export var shader_normal:Color
@export var shader_hover:Color
@export var exec_class:String
@export var execute:String
@export var args:Array
var state_machine:StateMachine2 = StateMachine2.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Add("hover_state", IconButtonHoverState.new(self, "init hover icon args"))
	state_machine.Add("normal", IconButtonNormalState.new(self, "init normal icon button args"))	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)



func _on_mouse_entered():
	state_machine.Change("hover_state", args)



func _on_mouse_exited():
	state_machine.Change("normal", null)
