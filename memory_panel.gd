extends ColorRect

var state_machine = StateMachine2.new()
var mem_inventory = []#Array of strings containing word ids, like "noun_wound"

func _init():
	#Add various states to the state_machine here
	#Loading a wound that has been clicked
	#Hovering over a loaded word
	#Selecting a word for swap in the parser
	#Swapping when a word in the parser has already been selected.
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
