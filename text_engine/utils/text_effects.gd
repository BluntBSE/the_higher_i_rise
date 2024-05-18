extends Node
class_name TextEffects

static var selected = {
	"open": "[wave amp=50.0 freq=5.0 connected=1][b]",
	"close": "[/b][/wave]"
}

static var locked_option = {
	"open": "[color=#ffffff78]",
	"close": "[/color]"
}

static var hover = {
	"open": "[b]",
	"close":"[/b]"
}

static var wound = {
	"open": "[shake rate=8.0 level=3 connected=1]{text}[/shake]",
	"close": "[/shake]"
} 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
