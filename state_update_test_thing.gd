extends ColorRect
var state_machine = StateMachine2.new()

func _init():
	state_machine.Add("debug", FinishedMemoriesState.new(self, "init new memories"))
# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Change("debug", null)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)

