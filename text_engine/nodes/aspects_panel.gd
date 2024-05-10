extends ColorRect
class_name AspectPanel

var state_machine: StateMachine2 = StateMachine2.new()
var aspect_dict = {"curious": 2, "compassionate": 2, "pragmatic": 2}

func _init():
	#Add various states to the state_machine here"))
	state_machine.Add("refresh", RefreshAspectsState.new(self,"Init refresh memory state"))
	state_machine.Add("finished", FinishedAspectsState.new(self, "init finished state"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	state_machine.Change("refresh", null)
	pass
	
func _process(delta):

	state_machine.stateUpdate(delta)
	
