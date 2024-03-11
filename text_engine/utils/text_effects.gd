extends Node
class_name TextEffects

static var selected = {
	"open": "[wave amp=50.0 freq=5.0 connected=1][b]",
	"close": "[/b][/wave]"
}

static var hover = {
	"open": "[b]",
	"close":"[/b]"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
