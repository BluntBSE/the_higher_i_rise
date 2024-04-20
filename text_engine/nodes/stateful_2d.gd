extends Control
class_name StatefulControl


class StateMachine:

	var _stateDict = {}
	var _current = EmptyState.new();
	func getCurrent():
		return _current
	func Add(state_id:String, state):
		_stateDict[state_id] = state
	func Remove(state_id:String):
		_stateDict.erase(state_id)
	func Clear():
		_stateDict = {}
	func Change(state_id:String, args):
		_current.stateExit()
		var next = _stateDict[state_id]
		next.stateEnter(args)
		_current = next
		
	#To call any parent functionality (presently none), call super()
	
	func stateUpdate(dt):
		_current.stateUpdate(dt)

		
		
	func handleInput():
		_current.stateHandleInput()
		
		


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
