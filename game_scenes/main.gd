extends Control
#Script for governing things like opening menus, controlling settings, etc.

var state_machine = StateMachine2.new()


# Called when the node enters the scene tree for the first time.

func _init():
	state_machine.Add("menu_open", PauseMenuOpenState.new(self,"init mm open state"))
	state_machine.Add("playing", PlayingGameState.new(self, "init playing state"))
	
func _ready():
	state_machine.Change("playing", null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	
	if Input.is_key_label_pressed(KEY_SEMICOLON):
		print("Got semicolon press")
		get_tree().quit()
	pass
